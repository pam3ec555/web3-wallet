//
//  AuthorizeScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 09.07.2023.
//

import SwiftUI
import Combine

struct AuthorizeScreen: View {
  @EnvironmentObject private var authVM: AuthVM
  
  var body: some View {
    PinCodeTextField(label: "auth.enterPinCode", isFocused: true) { code, completion in
      authVM.authorize(code) { error in
        if let unwrappedError = error {
          switch unwrappedError {
          case .invalidPassword:
            completion(AppError.localizedText("sharedErrors.invalidPassword"))
            break
          case .mnemonicDoesNotExist:
            completion(AppError.localizedText("auth.mnemonicDoesNotExist"))
            break
          default:
            completion( AppError.localizedText("sharedErrors.somethingWentWrong"))
          }
        } else {
          completion(nil)
        }
      }
    }
  }
}

struct AuthorizeScreen_Previews: PreviewProvider {
  static var previews: some View {
    AuthorizeScreen()
  }
}
