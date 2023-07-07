//
//  RestoreSeedPhraseScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import SwiftUI
import Bip39

struct RestoreSeedPhraseScreen: View {
  @State private var text: String = ""
  @State private var fieldErrorText: LocalizedStringKey? = nil
  @EnvironmentObject private var authVM: AuthVM
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Spacer()
      TextField("restoreSeed.seedPhraseLabel", text: $text)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onChange(of: text) { value in
          fieldErrorText = nil
        }
      if fieldErrorText != nil {
        Text(fieldErrorText ?? "").foregroundColor(.red)
      }
      Text("restoreSeed.description").font(.footnote)
      Spacer()
      Button(action: {
        let phrase = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if Mnemonic.isValid(phrase: phrase.components(separatedBy: " ")) {
          let isStored = authVM.storeSeedPhrase(seedPhrase: phrase)
          if (!isStored) {
            fieldErrorText = "sharedErrors.somethingWentWrong"
          }
        } else {
          fieldErrorText = "restoreSeed.invalidSeedPhraseFormat"
        }
      }) {
        Text("shared.continue")
      }.buttonStyle(PrimaryButtonStyle())
    }.padding()
  }
}

struct RestoreSeedPhraseScreen_Previews: PreviewProvider {
  static var previews: some View {
    RestoreSeedPhraseScreen()
  }
}
