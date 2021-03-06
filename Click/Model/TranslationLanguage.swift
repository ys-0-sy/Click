//
//  File.swift
//  Clip
//
//  Created by saito on 2020/04/20.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

struct TranslationLanguage: Codable, Hashable {
  var language: String
  var name: String
}

struct TranslationLanguages: Decodable {
  var languages: [TranslationLanguage]
}
