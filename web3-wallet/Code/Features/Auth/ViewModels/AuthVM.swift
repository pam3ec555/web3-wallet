//
//  AuthVM.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import Foundation
import Web3Core

enum AuthorizationError: Error {
  case unknown
  case mnemonicDoesNotExist
  case invalidPassword
}

typealias AuthorizeCompletion = (AuthorizationError?) -> Void

class AuthVM: ObservableObject {
  @Published private(set) var mnemonic: String?
  @Published private(set) var hasPassword: Bool = false
  @Published private(set) var keystore: BIP32Keystore?
  
  var hasMnemonic: Bool {
    get {
      mnemonic != nil
    }
  }
  
  var isAuthorized: Bool {
    get {
      keystore != nil
    }
  }
  
  let repository: AuthRepository
  
  init(repository: AuthRepository) {
    self.repository = repository
    mnemonic = repository.retreiveMnemonic()
    hasPassword = repository.hasPassword()
  }
  
  func setPassword(_ password: String, completion: @escaping AuthorizeCompletion) {
    guard let unwrappedMnemonic = mnemonic else {
      completion(AuthorizationError.mnemonicDoesNotExist)
      return
    }
    let isStored = repository.setPassword(password)
    if isStored {
      initKeystore(password: password, mnemonic: unwrappedMnemonic, completion: { error in
        if let unwrappedError = error {
          completion(unwrappedError)
        } else {
          self.hasPassword = true
        }
      })
    } else {
      completion(AuthorizationError.unknown)
    }
  }
  
  func authorize(_ password: String, completion: @escaping AuthorizeCompletion) {
    guard let unwrappedMnemonic = mnemonic else {
      completion(AuthorizationError.mnemonicDoesNotExist)
      return
    }
    let passwordIsValid = repository.validatePassword(with: password)
    if !passwordIsValid {
      completion(AuthorizationError.invalidPassword)
      return
    }
    
    initKeystore(password: password, mnemonic: unwrappedMnemonic, completion: completion)
  }
  
  private func initKeystore(password: String, mnemonic: String, completion: @escaping AuthorizeCompletion) {
    DispatchQueue.global(qos: .userInteractive).async {
      do {
        let keystore = try BIP32Keystore(
          mnemonics: mnemonic,
          password: password
        )
        DispatchQueue.main.async {
          self.keystore = keystore
          completion(nil)
        }
      } catch {
        completion(AuthorizationError.unknown)
      }
    }
  }
  
  func storeMnemonic(_ newMnemonic: String) -> Bool {
    let isStored = repository.storeMnemonic(newMnemonic)
    if isStored {
      mnemonic = newMnemonic
    }
    return isStored
  }
  
  func retrieveMnemonic() -> String? {
    return repository.retreiveMnemonic()
  }
  
  func clear() -> Bool {
    let isCleared = repository.clearMnemonic() && repository.clearPassword()
    if (isCleared) {
      mnemonic = nil
      keystore = nil
      hasPassword = false
    }
    return isCleared
  }
}
