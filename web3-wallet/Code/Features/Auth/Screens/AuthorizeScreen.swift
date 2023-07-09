//
//  AuthorizeScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 09.07.2023.
//

import SwiftUI
import Combine

struct AuthorizeScreen: View {
  @StateObject private var authVM = AuthVM(repository: AuthRepositoryImpl())
  
  var body: some View {
    PinCodeTextField(label: "auth.enterPinCode", isFocused: true) { code in
      do {
        try authVM.authorize(code)
      } catch AuthorizationError.mnemonicDoesNotExist {
        throw AppError.localizedText("auth.mnemonicDoesNotExist")
      } catch AuthorizationError.invalidPassword {
        throw AppError.localizedText("sharedErrors.invalidPassword")
      } catch {
        throw AppError.localizedText("sharedErrors.somethingWentWrong")
      }
    }
  }
}

struct AuthorizeScreen_Previews: PreviewProvider {
  static var previews: some View {
    AuthorizeScreen()
  }
}
