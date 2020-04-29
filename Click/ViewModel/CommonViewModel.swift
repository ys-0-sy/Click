//
//  CommonViewModel.swift
//  Cl!ck
//
//  Created by saito on 2020/04/29.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import Combine

class CommonViewModel: ObservableObject {
  @Published var cards: [Cards]
  @Published var hasCards: Bool
  
  private var history: [Cards] = []
  
  init() {
    self.cards = []
    self.hasCards = false
    self.fetchAll()
  }
  
  func History() -> [Cards] {
    if cards.count < 5 {
      if cards.count < history.count {
        return history
      }
    }
    history = self.cards.suffix(5)
    return history
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
      CoreDataModel.save()
    }
    fetchAll()
  }
}
