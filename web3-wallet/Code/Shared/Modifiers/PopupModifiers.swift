//
//  PopupModifier.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 06.07.2023.
//

import SwiftUI

enum ToastType {
  case danger
  case success
}

struct ToastParams {
  var type: ToastType = .success
  
  public func type(_ type: ToastType) -> ToastParams {
    var params = self
    params.type = type
    return params
  }
}

fileprivate func getBackgroundColorByType(_ type: ToastType) -> Color {
  switch type {
  case .danger: return Color.red
  case .success: return Color.green
  }
}

extension View {
  func toast<Content: View>(
    isPresented: Binding<Bool>,
    @ViewBuilder content: @escaping () -> Content,
    customize: @escaping (ToastParams) -> ToastParams = { $0 }
  ) -> some View {
    var params = ToastParams()
    params = customize(params)
    
    return self.popup(isPresented: isPresented) {
      Group {
        content()
          .padding()
          .frame(maxWidth: .infinity)
          .background(getBackgroundColorByType(params.type))
          .cornerRadius(8)
          .foregroundColor(.white)
      }.padding()
    } customize: {
      $0
        .type(.floater())
        .position(.top)
        .animation(.spring())
        .dragToDismiss(true)
        .autohideIn(2)
    }
  }
}

