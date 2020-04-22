//
//  File.swift
//  Cl!ck
//
//  Created by saito on 2020/04/23.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

struct DetectionLanguageRequest: RequestType {
  typealias Response = DetectionLanguageResponse
  
  var path: String { return "/language/translate/v2/detect" }
  var queryItems: [URLQueryItem]? {
    return [
      .init(name: "key", value: self.loadKeys()),
      .init(name: "q", value: query)
    ]
  }
  
  private let query: String

  init(query: String) {
      self.query = query
  }
  
  private func loadKeys() -> String {
    do {
      let settingURL: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "keys", ofType: "plist")!)
      let data = try Data(contentsOf: settingURL)
      let decoder = PropertyListDecoder()
      let keys = try decoder.decode(Keys.self, from: data)
      return keys.googleAPIKey
    } catch {
      print("apiKeyget error")
      print(error)
      return ""
    }
  }
}
