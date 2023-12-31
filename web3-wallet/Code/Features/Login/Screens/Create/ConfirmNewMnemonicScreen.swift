//
//  ConfirmNewSeedPhraseScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 06.07.2023.
//

import SwiftUI

struct ConfirmNewMnemonicScreen: View {
  let seedPhrase: String

  @State private var text: String = ""
  @State private var fieldErrorText: LocalizedStringKey? = nil
  @EnvironmentObject private var authVM: AuthVM
  
  init(_ seedPhrase: String) {
    self.seedPhrase = seedPhrase
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Spacer()
      TextField("createSeed.seedPhraseLabel", text: $text)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onChange(of: text) { value in
          fieldErrorText = nil
        }
      if let errorText = fieldErrorText {
        Text(errorText).foregroundColor(.red)
      }
      Text("createSeed.enterSeedPhrase").font(.footnote)
      Spacer()
      Button(action: {
        if (text == seedPhrase) {
          let isStored = authVM.storeMnemonic(seedPhrase)
          if (!isStored) {
            fieldErrorText = "sharedErrors.somethingWentWrong"
          }
        } else {
          fieldErrorText = "createSeed.invalidSeedPhrase"
        }
      }) {
        Text("shared.continue")
      }.buttonStyle(PrimaryButtonStyle())
    }.padding()
  }
}

struct ConfirmNewSeedPhraseScreen_Previews: PreviewProvider {
  static var previews: some View {
    ConfirmNewMnemonicScreen("")
  }
}
