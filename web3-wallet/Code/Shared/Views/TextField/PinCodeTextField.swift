//
//  CodeTextField.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 09.07.2023.
//

import SwiftUI

/// Returns error text if some error was occured. Otherwise returns nil
typealias OnEnterDone = (String, @escaping (AppError?) -> Void) -> Void

struct PinCodeTextField: View {
  @State private var code: String = ""
  @State private var errorText: LocalizedStringKey? = nil
  @State private var isFieldShaking: Bool = false
  @State private var isSubmitting: Bool = false
  @FocusState private var isTextFieldFocused: Bool
  
  let maxCodeLength = 4
  
  let label: LocalizedStringKey
  let isInitiallyFocused: Bool
  let onEnterDone: OnEnterDone
  
  init(
    label: LocalizedStringKey,
    isFocused: Bool = false,
    onEnterDone: @escaping OnEnterDone
  ) {
    self.label = label
    self.isInitiallyFocused = isFocused
    self.onEnterDone = onEnterDone
  }
  
  var body: some View {
    VStack {
      VStack(alignment: .center, spacing: 20) {
        Text(label).font(.title)
        HStack(spacing: 12) {
          ForEach(0...(maxCodeLength - 1), id: \.self) { index in
            Image(systemName: self.getImageName(at: index))
              .font(.title2)
          }
        }.shake($isFieldShaking)
        VStack {
          if isSubmitting {
            ProgressView()
          } else if let unwrappedError = errorText {
            Text(unwrappedError).foregroundColor(.red)
          }
        }.frame(minHeight: 32)
      }
      .padding()
      .contentShape(Rectangle())
      .onTapGesture {
        isTextFieldFocused.toggle()
      }
      
      TextField("", text: $code)
        .focused($isTextFieldFocused)
        .accentColor(.clear)
        .foregroundColor(.clear)
        .keyboardType(.numberPad)
        .frame(width: 0, height: 0)
        .onAppear {
          if isInitiallyFocused {
            isTextFieldFocused = true
          }
        }
        .disabled(isSubmitting)
        .onChange(of: code) { newValue in
          if errorText != nil {
            errorText = nil
          }
          
          if newValue.count > maxCodeLength {
            code = String(newValue.prefix(maxCodeLength))
          } else {
            code = newValue
          }
          
          if code.count == maxCodeLength {
            DispatchQueue.main.async {
              isSubmitting = true
              onEnterDone(code) { error in
                code = ""
                isSubmitting = false
                if let unwrappedError = error {
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isFieldShaking = true
                    isTextFieldFocused = true
                    switch unwrappedError {
                    case .localizedText(let errorMessage):
                      errorText = errorMessage
                      break
                    }
                  }
                }
              }
            }
          }
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .contentShape(Rectangle())
    .onTapGesture {
      isTextFieldFocused = false
    }
  }
  
  private func getImageName(at index: Int) -> String {
    if index >= code.count {
      return "circle"
    }
    
    return "circle.fill"
  }
}

struct CodeTextField_Previews: PreviewProvider {
  static var previews: some View {
    PinCodeTextField(label: "Enter code") {code, completion in }
  }
}
