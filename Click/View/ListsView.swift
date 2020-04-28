//
//  ListsView.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import CoreData

struct ListsView: View {
  @ObservedObject var model: ListViewModel
  
  init() {
    self.model = ListViewModel()
  }
  
  var body: some View {
    VStack{
      if self.model.hasCards {
        ForEach(self.model.cards, id: \.self) { card in
          VStack {
            HistoryView(card: card, width: 200)
          Text("\(card.sourceText)")
          }
        }
      } else {
        Text("NO Data")
      }
    }.onAppear(perform: self.model.onAppear)
  }

}


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
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
