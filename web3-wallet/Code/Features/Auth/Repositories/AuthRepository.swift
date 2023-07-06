//
//  AuthRepository.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import Foundation

let kCryptoSeedKey = "CryptoSeed"

protocol AuthRepository {
  func storeSeedPhrase(_ seedPhrase: String) -> Bool
  
  func retreiveSeedPhrase() -> String?
  
  func clearSeedPhrase() -> Bool
}

struct AuthRepositoryImpl: AuthRepository {
  func storeSeedPhrase(_ seedPhrase: String) -> Bool {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: kCryptoSeedKey,
        kSecValueData as String: seedPhrase.data(using: .utf8)!,
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
  
  func retreiveSeedPhrase() -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: kCryptoSeedKey,
        kSecMatchLimit as String: kSecMatchLimitOne,
        kSecReturnData as String: true
    ]

    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)

    guard status == errSecSuccess,
      let data = result as? Data,
      let seedPhrase = String(data: data, encoding: .utf8) else {
      print("Failed to retrieve seed phrase from keychain. Status: \(status)")
      return nil
    }

    return seedPhrase
  }
  
  func clearSeedPhrase() -> Bool {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: kCryptoSeedKey,
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
}
