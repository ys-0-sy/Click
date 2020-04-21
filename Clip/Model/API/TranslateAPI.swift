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
