//
//  FetchSupportedLanguages.swift
//  Clip
//
//  Created by saito on 2020/04/20.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

struct FetchSupportedLanguageResponse: Decodable {
  var data: TranslationLanguages
}

struct DetectionLanguageResponse: Decodable {
  var data: DetectionLanguages
}



struct TranslationResponse: Decodable {
  var data: TranslatedLanguages
}

