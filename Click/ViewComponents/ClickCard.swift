//
//  ClickCard.swift
//  Cl!ck
//
//  Created by saito on 2020/05/01.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct ClickCard: View {
  @ObservedObject var card: Cards
  @State private var onCard = true
  
  var Colors = [Color("SubColor"), Color("SecondSubColor")]

    var body: some View {
        Button(action: {
          withAnimation(.easeInOut) {
            self.onCard.toggle()
          }
        }) {
          Text(self.onCard ? card.sourceText : card.translateText)
            .transition(.opacity)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 100, alignment: .center)
            .background(self.onCard ? self.Colors[0] : self.Colors[1])
            .rotation3DEffect(.degrees(self.onCard ? 180 : 1), axis: (x: 0, y: self.onCard ? 0 : 1, z: 0))
          .cornerRadius(8)
        }
    }
}

struct ClickCard_Previews: PreviewProvider {
    static var previews: some View {
      ClickCard(card: Cards.init())
    }
}
