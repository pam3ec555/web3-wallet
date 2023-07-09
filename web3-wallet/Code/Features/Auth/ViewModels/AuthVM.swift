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

class AuthVM: ObservableObject {
  @Published private(set) var mnemonic: String?
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
  }
  
  func authorize(_ password: String) throws {
    guard let unwrappedMnemonic = mnemonic else {
      throw AuthorizationError.mnemonicDoesNotExist
    }
    let passwordIsValid = repository.validatePassword(with: password)
    if !passwordIsValid {
      throw AuthorizationError.invalidPassword
    }
    do {
      keystore = try BIP32Keystore(
        mnemonics: unwrappedMnemonic,
        password: password
      )
      print("Address = \(keystore?.addresses?.first)")
    } catch {
      throw AuthorizationError.unknown
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
    let isCleared = repository.clearMnemonic()
    if (isCleared) {
      mnemonic = nil
      keystore = nil
    }
    return isCleared
  }
}
