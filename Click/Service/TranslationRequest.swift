//
//  TranslationRequest.swift
//  Cl!ck
//
//  Created by saito on 2020/04/23.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

struct TranslationRequest: RequestType {
  typealias Response = TranslationResponse
  
  var path: String { return "/language/translate/v2" }
  var queryItems: [URLQueryItem]? {
    return [
      .init(name: "key", value: self.loadKeys()),
      .init(name: "q", value: query),
      .init(name: "target", value: targetLanguage.language),
      .init(name: "source", value: sourceLanguage?.language)
    ]
  }
  
  private let query: String
  private let targetLanguage: TranslationLanguage
  private let sourceLanguage: TranslationLanguage?

  init(query: String, targetLanguage: TranslationLanguage, sourceLanguage: TranslationLanguage?) {
    self.query = query
    self.targetLanguage = targetLanguage
    self.sourceLanguage = sourceLanguage
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
