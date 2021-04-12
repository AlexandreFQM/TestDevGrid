//
//  DataConfig.swift
//  TestGists
//
//  Created by Alexandre Furquim on 07/04/21.
//

import Foundation

 public enum NetworkError: Error {
     case badURL
     case badJSONFormat
     case unknownError
     case userNotLogged
 }

 struct DataConfig {
     
     static public func getEntryPoint() -> URL {
         switch NetworkConfig.shared.environment {
         case .develop?:
             return URL(string: "https://api.github.com")!
         case .qa:
             return URL(string: "https://api.github.com")!
         case .prod?:
             return URL(string: "https://api.github.com")!
         case .none:
             return URL(string: "https://api.github.com")!
         }
     }

     static public func getAPIKey() -> String {
         // used for testing
         return "DEMO_KEY"
     }
 }
