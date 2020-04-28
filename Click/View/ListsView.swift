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
    GeometryReader { geometry in
      ScrollView {
        if self.model.hasCards {
          ForEach(self.model.cards, id: \.self) { card in
            HistoryView(card: card, width: UIScreen.main.bounds.width * 0.95)
          }
        } else {
          Text("NO Data")
            .frame(width: UIScreen.main.bounds.width)
        }
      }
      .frame(width: 200)
      .onAppear(perform: self.model.onAppear)
    }

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
