//
//  ListsView.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct ListsView: View {
  @ObservedObject var model: ListViewModel
  
  init() {
    self.model = ListViewModel()
  }
    var body: some View {
      List {
        ForEach(self.model.cards) { card in
          Text(card.sourceText)
        }
      }.onAppear(perform: self.model.onApper)
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
  func onApper() {
    fetchAll()
  }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
