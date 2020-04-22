//
//  TranslatedLanguage.swift
//  Cl!ck
//
//  Created by saito on 2020/04/23.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

struct TranslatedLanguages: Decodable {
  var translations: [[TranslatedLanguage]]
}

struct TranslatedLanguage: Decodable, Hashable {
  var translatedText: String
  var detectedSourceLanguage: String
}
