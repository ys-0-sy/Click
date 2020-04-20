//
//  FetchSupportedLanguageRequest.swift
//  Clip
//
//  Created by saito on 2020/04/20.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

struct FetchSupportedLanguageRequest: FetchSupportedLanguageRequestType {
  typealias Response = FetchSupportedLanguageResponse
  
  var path: String { return "/language/translate/v2/languages" }
  var queryItems: [URLQueryItem]? {
    return [
      .init(name: "key", value: self.loadKeys()),
      .init(name: "target", value: Locale.current.languageCode ?? "en")
    ]
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
