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
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.id, ascending: true)], animation: .default) var cards: FetchedResults<Card>
  @Environment(\.managedObjectContext) var viewContext
  
  @ObservedObject var model: ListViewModel
  
  init() {
    self.model = ListViewModel()
  }
  
  var body: some View {
    List {
      ForEach(cards, id: \.self) { card in
        ListView(card: card)
      }
      .onDelete { indeces in
        self.cards.delete(at: indeces, from: self.viewContext)
      }
    }
      .navigationBarTitle("Words List")
      .frame(width: UIScreen.main.bounds.width)
//      .onAppear(perform: self.common.onAppear)
  }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
