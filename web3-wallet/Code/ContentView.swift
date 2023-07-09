//
//  ContentView.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 02.07.2023.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var authVM = AuthVM(repository: AuthRepositoryImpl())
  @StateObject private var config = AppConfiguration()
  
  var body: some View {
    Group {
      if authVM.hasMnemonic {
        if authVM.isAuthorized {
          MainScreen()
        } else {
          AuthorizeScreen()
        }
      } else {
        IntroScreen()
      }
    }
    .environmentObject(authVM)
    .environmentObject(config)
    .environment(\.locale, .init(identifier: "en"))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
