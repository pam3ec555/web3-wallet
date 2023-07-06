//
//  IntroScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import SwiftUI

struct IntroScreen: View {
  var body: some View {
    VStack(spacing: 8) {
      Spacer()
      Text("intro.welcome")
        .font(.title)
      Text("intro.description").multilineTextAlignment(.center)
      Spacer()
      VStack(spacing: 20) {
        NavigationLink() {
          CreateSeedPhraseScreen()
        } label: {
          Text("intro.create").frame(maxWidth: .infinity)
        }.buttonStyle(PrimaryButton())
        NavigationLink() {
          RestoreSeedPhraseScreen()
        } label: {
          Text("intro.restore")
        }
        .buttonStyle(TextButton())
      }
    }.padding()
  }
}

struct IntroScreen_Previews: PreviewProvider {
  static var previews: some View {
    IntroScreen()
  }
}
