//
//  Configuration.swift
//  web3-wallet
//
//  Created by Ramil Rakhmatullin on 08.07.2023.
//

import Foundation

struct ConfigModel {
  let rpcURL: String
  
  init(rpcURL: String) {
    self.rpcURL = rpcURL
  }
  
  init(_ dict: NSDictionary) {
    guard let rpcURL = dict["rpcURL"] as? String else {
      fatalError("rpcURL is missing or invalid.")
    }
    
    self.rpcURL = rpcURL
  }
}

class AppConfiguration: ObservableObject {
  private(set) var data: ConfigModel
  
  init() {
    guard let configurationURL = Bundle.main.url(forResource: "Configuration", withExtension: "plist"),
          let configurationDict = NSDictionary(contentsOf: configurationURL) else {
      fatalError("Unable to load configuration file.")
    }
    data = ConfigModel(configurationDict)
  }
}
