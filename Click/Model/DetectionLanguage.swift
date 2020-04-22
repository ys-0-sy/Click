//
//  DetectionLanguage.swift
//  Cl!ck
//
//  Created by saito on 2020/04/23.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

struct DetectionLanguages: Decodable {
  var detections: [[DetectionLanguage]]
}

struct DetectionLanguage: Decodable, Hashable {
  var language: String
  var confidence: Float
}
