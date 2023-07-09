//
//  WalletScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 08.07.2023.
//

import SwiftUI

struct WalletScreen: View {
  @StateObject var walletVM: WalletVM
  
  init(seedPhrase: String, rpcURL: String) {
    let walletVMObject = WalletVM(
      seedPhrase: seedPhrase,
      walletRepository: WalletRepositoryImpl(
        providerUrl: rpcURL
      )
    )
    _walletVM = StateObject(wrappedValue: walletVMObject)
    walletVM.getBalance()
  }
  
  var body: some View {
    VStack {
      Text("Wallet")
    }.navigationTitle("wallet.title")
  }
}

struct WalletScreen_Previews: PreviewProvider {
  static var previews: some View {
    WalletScreen(seedPhrase: "Seed phrase", rpcURL: "https://some-url")
  }
}
