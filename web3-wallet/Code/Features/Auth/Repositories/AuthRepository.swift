//
//  AuthRepository.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import Foundation

let kCryptoMnemonic = "CryptoMnemonic"
let kWalletPassword = "WalletPassword"

protocol AuthRepository {
  func storeMnemonic(_ phrase: String) -> Bool
  
  func retreiveMnemonic() -> String?
  
  func clearMnemonic() -> Bool
  
  func createPassword(_ password: String) -> Bool
  
  func validatePassword(with password: String) -> Bool
  
  func clearPassword() -> Bool
}

struct AuthRepositoryImpl: AuthRepository {
  func storeMnemonic(_ phrase: String) -> Bool {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: kCryptoMnemonic,
      kSecValueData as String: phrase.data(using: .utf8)!,
      kSecAttrAccessible as String:
        kSecAttrAccessibleWhenUnlockedThisDeviceOnly
    ]
    
    // Remove existing item with the same account name, if any
    SecItemDelete(query as CFDictionary)
    
    let status = SecItemAdd(query as CFDictionary, nil)
    guard status == errSecSuccess else {
      print("Failed to store seed phrase in keychain. Status: \(status)")
      return false
    }
    
    return true
  }
  
  func retreiveMnemonic() -> String? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: kCryptoMnemonic,
      kSecMatchLimit as String: kSecMatchLimitOne,
      kSecReturnData as String: true
    ]
    
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    guard status == errSecSuccess,
          let data = result as? Data,
          let mnemonic = String(data: data, encoding: .utf8) else {
      print("Failed to retrieve seed phrase from keychain. Status: \(status)")
      return nil
    }
    
    return mnemonic
  }
  
  func clearMnemonic() -> Bool {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: kCryptoMnemonic,
      kSecAttrAccessible as String:
        kSecAttrAccessibleWhenUnlockedThisDeviceOnly
    ]
    
    let status = SecItemDelete(query as CFDictionary)
    guard status == errSecSuccess else {
      print("Failed to delete seed phrase in keychain. Status: \(status)")
      return false
    }
    
    return true
  }
  
  func createPassword(_ password: String) -> Bool {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: kWalletPassword,
      kSecValueData as String: password.data(using: .utf8)!,
      kSecAttrAccessible as String:
        kSecAttrAccessibleWhenUnlockedThisDeviceOnly
    ]
    
    // Remove existing item with the same account name, if any
    SecItemDelete(query as CFDictionary)
    
    let status = SecItemAdd(query as CFDictionary, nil)
    guard status == errSecSuccess else {
      print("Failed to store a password in keychain. Status: \(status)")
      return false
    }
    
    return true
  }
  
  func validatePassword(with password: String) -> Bool {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: kWalletPassword,
      kSecMatchLimit as String: kSecMatchLimitOne,
      kSecReturnData as String: true
    ]
    
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    guard status == errSecSuccess,
          let data = result as? Data,
          let passwordFromKeyChain = String(data: data, encoding: .utf8) else {
      print("Failed to retrieve password from keychain. Status: \(status)")
      return false
    }
    
    return passwordFromKeyChain == password
  }
  
  func clearPassword() -> Bool {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: kWalletPassword,
      kSecAttrAccessible as String:
        kSecAttrAccessibleWhenUnlockedThisDeviceOnly
    ]
    
    let status = SecItemDelete(query as CFDictionary)
    guard status == errSecSuccess else {
      print("Failed to delete password from keychain. Status: \(status)")
      return false
    }
    
    return true
  }
}
