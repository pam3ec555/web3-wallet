//
//  SettingsScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 08.07.2023.
//

import SwiftUI

struct SettingsScreen: View {
  @EnvironmentObject private var authVM: AuthVM

  var body: some View {
    Button(action: {
      let _ = authVM.clear()
    }, label: {
      Text("LOGOUT")
    })
  }
}

struct SettingsScreen_Previews: PreviewProvider {
  static var previews: some View {
    SettingsScreen()
  }
}
