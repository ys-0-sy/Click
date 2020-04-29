//
//  ListsViewModel.swift
//  Cl!ck
//
//  Created by saito on 2020/04/29.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

class ListViewModel: ObservableObject {
  @Published var cards: [Cards]
  @Published var hasCards: Bool
  
  init() {
    self.cards = []
    self.hasCards = false
  }
  func fetchAll() {
    cards = CoreDataModel.getCards()
    hasCards = cards.count > 0
  }
  func onAppear(){
    fetchAll()
  }
  func onDelete(offsets: IndexSet) {
    if offsets.first != nil {
      CoreDataModel.delete(card: self.cards[offsets.first!])

    }
    CoreDataModel.save()
    fetchAll()
  }
}
