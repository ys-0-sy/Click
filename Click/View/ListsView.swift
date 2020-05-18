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
    VStack {
      RoundedRectangle(cornerRadius: 8)

        .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
        .border(Color("SubColor"), width: 3)
        .foregroundColor(Color.clear)
        .cornerRadius(8)
      VStack(spacing: 10) {
        HStack {
          Text("English")
          Text("Japanese")
        }
        VStack(spacing: 20) {
          ForEach(cards, id: \.self) { card in
            VStack {
            ListView(card: card, width: UIScreen.main.bounds.width * 0.9)
              .background(Color(UIColor.systemBackground))
              .cornerRadius(8)
            }
          }
          .onDelete { indeces in
            self.cards.delete(at: indeces, from: self.viewContext)
          }
        }
        .frame(width: UIScreen.main.bounds.width * 0.95)
        .cornerRadius(8)
        Spacer()
      }
      .background(Color(UIColor.systemGray6))
      .cornerRadius(8)
    }

      .navigationBarTitle("Words List")
  }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
