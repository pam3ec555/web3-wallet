//
//  MainScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import SwiftUI

struct MainScreen: View {
  var body: some View {
    TabView {
      WalletScreen()
        .tabItem {
          Image(systemName: "bitcoinsign.circle")
          Text("wallet.title")
        }
      SettingsScreen()
        .tabItem {
          Image(systemName: "gear")
          Text("settings.title")
        }
    }
  }
}

struct MainScreen_Previews: PreviewProvider {
  static var previews: some View {
    MainScreen()
  }
}
