//
//  CardsView.swift
//  Cl!ck
//
//  Created by saito on 2020/05/01.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct CardsView: View {
  @Environment(\.managedObjectContext) var viewContext
  @ObservedObject var common: CommonViewModel
  init() {
    self.common = CommonViewModel()
  }
    var body: some View {
      
      ZStack {
        ForEach(self.common.cards) { card in
          ClickCard(card: card)
          .animation(.easeInOut)
        }
      }
      .padding()
      .frame(width: UIScreen.main.bounds.width * 0.95)
      .background(Color(.systemGray6))
      .cornerRadius(8)
      .navigationBarTitle("Click")
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
