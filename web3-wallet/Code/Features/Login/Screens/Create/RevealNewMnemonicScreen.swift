//
//  RevealNewSeedPhraseScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 06.07.2023.
//

import SwiftUI
import Bip39

struct RevealNewMnemonicScreen: View {
  @Environment(\.presentationMode) var presentationMode

  @State private var isCopied = false
  
  private let seedPhrase: String
  
  init() {
    let mnemonic = try? Mnemonic()
    self.seedPhrase = mnemonic?.mnemonic().joined(separator: " ") ?? ""
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        VStack(alignment: .leading, spacing: 12) {
          Text("createSeed.yourSeedPhrase")
          CodeText(seedPhrase, isCopied: $isCopied)
          Text("createSeed.writeDownSeedPhraseNote").font(.footnote)
        }
        Spacer()
        NavigationLink {
          ConfirmNewMnemonicScreen(seedPhrase)
        } label: {
          Text("shared.continue")
        }.buttonStyle(PrimaryButtonStyle())
      }
      .padding()
      .toast(isPresented: $isCopied) {
        HStack(spacing: 8) {
          Image(systemName: "doc.on.doc")
          Text("shared.textWasCopied").multilineTextAlignment(.leading)
          Spacer()
        }
      }
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: backButton)
    }
  }
  
  var backButton: some View {
    Button(action: {
      self.presentationMode.wrappedValue.dismiss()
    }) {
      Text("shared.close")
    }.buttonStyle(TextButtonStyle())
  }
}

struct RevealNewSeedPhraseScreen_Previews: PreviewProvider {
  static var previews: some View {
    RevealNewMnemonicScreen()
  }
}
