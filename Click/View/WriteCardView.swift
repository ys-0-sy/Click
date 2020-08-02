//
//  WriteCardView.swift
//  Cl!ck
//
//  Created by saito on 2020/08/02.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct WriteCardView: View {
  var cards: [Card]
  var body: some View {
    HStack {
      ForEach(cards) { card in
        Text(card.translateText)
      }
    }
  }
}

//struct WriteCardView_Previews: PreviewProvider {
//  static var previews: some View {
//    WriteCardView(cards: Card.init())
//  }
//}
