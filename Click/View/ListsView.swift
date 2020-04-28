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
      ForEach(self.model.cards, id: \.self) { card in
          HistoryView(sourceText: card.sourceText, translationText: card.translateText, sourceLanguage: card.sourceLanguage, translationLanguage: card.translateLanguage, width: 200)
        }
        
      .onAppear(perform: self.model.onAppear)
    }
}


class ListViewModel: ObservableObject {
  @Published var cards: [Cards]
  init() {
    self.cards = []
  }
  func fetchAll() {
    cards = CoreDataModel.getCards()
  }
  func onAppear() {
    fetchAll()
  }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
