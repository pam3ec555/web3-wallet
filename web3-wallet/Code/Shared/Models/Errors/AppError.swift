//
//  CommonError.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 09.07.2023.
//

import Foundation
import SwiftUI

enum AppError: Error {
  case localizedText(_ message: LocalizedStringKey)
}
