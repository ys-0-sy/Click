//
//  CardsModel.swift
//  Memolation
//
//  Created by saito on 2020/04/12.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

struct Card: Decodable, Hashable, Identifiable {
  let id: Int
  let language: Language
  let sourceText: String
  let targetText: String
  let isRemembered: Bool
}

struct Language: Decodable, Hashable, Identifiable {
  let id: Int
  let sourceLanguage: String
  let targetLanguage: String
}

struct CardList {
  let items: [Card]
}
