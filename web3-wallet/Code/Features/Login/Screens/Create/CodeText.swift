//
//  CopiedText.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 06.07.2023.
//

import SwiftUI
import PopupView

struct CodeText: View {
  @Binding var isCopied: Bool;
  
  let text: String
  
  init(_ text: String, isCopied: Binding<Bool>) {
    self.text = text
    _isCopied = isCopied
  }
  
  var body: some View {
    HStack(alignment: .top) {
      Text(text)
        .font(.system(.body, design: .monospaced))
      
      Button(action: {
        copyTextToClipboard()
        isCopied = true
      }) {
        Image(systemName: "doc.on.doc")
          .foregroundColor(.blue)
      }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(8.0)
  }
  
  private func copyTextToClipboard() {
    UIPasteboard.general.string = text
  }
}

struct CopiedText_Previews: PreviewProvider {
  static var previews: some View {
    CodeText("Some text\n\n", isCopied: .constant(false))
  }
}
