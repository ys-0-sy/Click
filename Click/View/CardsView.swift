//
//  CardsView.swift
//  Cl!ck
//
//  Created by saito on 2020/05/01.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct CardsView: View {
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.id,
                                                   ascending: true)], animation: .default) var card: FetchedResults<Card>
  @Environment(\.managedObjectContext) var viewContext
    var body: some View {
      PurchaseView()
//      ZStack {
//        ForEach(card) { card in
//          ClickCard(card: card)
//          .animation(.easeInOut)
//        }
//      }
//      .padding()
//      .frame(width: UIScreen.main.bounds.width * 0.95)
//      .background(Color(.systemGray6))
//      .cornerRadius(8)
      .navigationBarTitle("Click")
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
