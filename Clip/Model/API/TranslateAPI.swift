//
//  TranslateAPI.swift
//  Memolation
//
//  Created by saito on 2020/03/27.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
//import Alamofire
//import SwiftyJSON

enum TranslationAPI {
  case detectLanguage
  case transelate
  case supportedLanguages

  func getURL() -> String {
    var urlString = ""

    switch self {
      case .detectLanguage:
        urlString = "https://translation.googleapis.com/language/translate/v2/detect"
      case .transelate:
        urlString = "https://translation.googleapis.com/language/translate/v2"
      case .supportedLanguages:
        urlString = "https://translation.googleapis.com/language/translate/v2/languages"

    }
    return urlString
  }

  func getHTTPMethod() -> String {
    if self == .supportedLanguages {
      return "GET"
    } else {
      return "POST"
    }
  }
}

//class TestApi: ObservableObject {
//  @Published var responseString: String = "Initializing..."
//
//  init() {
//    translate(rawString: "")
//  }
//
//  private func loadKeys() -> String {
//    do {
//      let settingURL: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "keys", ofType: "plist")!)
//      let data = try Data(contentsOf: settingURL)
//      let decoder = PropertyListDecoder()
//      let keys = try decoder.decode(Keys.self, from: data)
//      return keys.googleAPIKey
//    } catch {
//      print("api get error")
//      print(error)
//      return ""
//    }
//  }
//  func translate(rawString: String) {
//    let googleAPIKey = loadKeys()
//    AF.request("https://translation.googleapis.com",
//               method: .post,
//               parameters: [
//                "q": rawString,
//                "target": "ja",
//                "key": googleAPIKey]).responseData {response in
//                  if let value = response.value {
//                    let json = JSON(value)
//                    print(json)
//                    if let translatedText = json["data"]["translations"][0]["translatedText"].string {
//                      debugPrint(translatedText)
//                      self.responseString = translatedText
//                    } else {
//                      self.responseString = "json parse error"
//                  }
//
//                  } else {
//                    self.responseString = "request Error"
//                  }
//      }
//    }
//}
