//
//  WalletVM.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 08.07.2023.
//

import Foundation

class WalletVM: ObservableObject {
  @Published var assets: [AssetModel] = []

  private let seedPhrase: String
  private let repository: WalletRepository
  
  init(seedPhrase: String, walletRepository: WalletRepository) {
    self.seedPhrase = seedPhrase
    self.repository = walletRepository
  }
  
  func getBalance() {
    repository.getBalance()
  }
}
