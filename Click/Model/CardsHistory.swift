//
//  CardsHistory.swift
//  Cl!ck
//
//  Created by saito on 2020/05/03.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

struct CardsHistory: Equatable, Hashable {
  var sourceLanguage: String
  var sourceText: String
  var translateLanguage: String
  var translateText: String
  var index: String
}
