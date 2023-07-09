//
//  WalletRepository.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 08.07.2023.
//

import Foundation

protocol WalletRepository {
  func getBalance()
}

struct WalletRepositoryImpl: WalletRepository {
  let providerUrl: String
  
  init(providerUrl: String) {
    self.providerUrl = providerUrl
  }
  
  func getBalance() {}
}
