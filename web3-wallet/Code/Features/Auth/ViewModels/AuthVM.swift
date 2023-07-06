//
//  AuthVM.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 05.07.2023.
//

import Foundation

class AuthVM: ObservableObject {
  @Published var hasSeedPhrase: Bool = false
  
  let repository: AuthRepository
  
  init(repository: AuthRepository) {
    self.repository = repository
    let initialSeedPhrase = repository.retreiveSeedPhrase()
    hasSeedPhrase = initialSeedPhrase != nil
  }
  
  func storeSeedPhrase(seedPhrase: String) -> Bool {
    let isStored = repository.storeSeedPhrase(seedPhrase)
    if isStored {
      hasSeedPhrase = true
    }
    return isStored
  }
  
  func retrieveSeedPhrase() -> String? {
    return repository.retreiveSeedPhrase()
  }
  
  func clearSeedPhrase() -> Bool {
    return repository.clearSeedPhrase()
  }
}
