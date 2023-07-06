//
//  PrimaryButton.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .padding()
      .background(Color.blue)
      .cornerRadius(8)
      .opacity(configuration.isPressed ? 0.8 : 1)
      .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
  }
}

struct PrimaryButton_Previews: PreviewProvider {
  static var previews: some View {
    Button(action: {}) {
      Text("Text")
    }.buttonStyle(PrimaryButton())
  }
}
