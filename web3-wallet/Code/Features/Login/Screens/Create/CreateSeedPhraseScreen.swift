//
//  CreateSeedPhraseScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import SwiftUI

struct CreateSeedPhraseScreen: View {
  @State private var isShowingSeed = false

  var body: some View {
    VStack {
      Spacer()
      Text("createSeed.description").multilineTextAlignment(.center)
      Spacer()
      Button(action: {
        isShowingSeed = true
      }) {
        Text("createSeed.showSeedPhrase")
      }
        .buttonStyle(PrimaryButtonStyle())
        .sheet(isPresented: $isShowingSeed) {
          RevealNewSeedPhraseScreen()
        }
    }
      .padding()
      .navigationTitle("createSeed.title")
  }
}

struct CreateSeedPhraseScreen_Previews: PreviewProvider {
  static var previews: some View {
    CreateSeedPhraseScreen()
  }
}
