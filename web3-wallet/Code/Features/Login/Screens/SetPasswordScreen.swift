//
//  SetPasswordScreen.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 10.07.2023.
//

import SwiftUI

struct SetPasswordScreen: View {
  @State var code: String? = nil
  @EnvironmentObject private var authVM: AuthVM
  
  var body: some View {
    PinCodeTextField(
      label: code != nil ? "auth.confirmPinCode" : "auth.createNewPinCode",
      isFocused: true
    ) { code, completion in
      if self.code != nil {
        if self.code == code {
          authVM.setPassword(code) { error in
            if error != nil {
              completion(AppError.localizedText("sharedErrors.somethingWentWrong"))
            } else {
              completion(nil)
            }
          }
        } else {
          self.code = nil
          completion(AppError.localizedText("auth.pinCodesDoNotMatch"))
        }
      } else {
        self.code = code
        completion(nil)
      }
    }
  }
}

struct SetPasswordScreen_Previews: PreviewProvider {
  static var previews: some View {
    SetPasswordScreen()
  }
}
