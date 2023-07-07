//
//  TextButton.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import SwiftUI

struct TextButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(Color.blue)
      .opacity(configuration.isPressed ? 0.6 : 1)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

struct TextButton_Previews: PreviewProvider {
  static var previews: some View {
    Button(action: {}) {
      Text("Text")
    }.buttonStyle(TextButtonStyle())
  }
}
