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
  @State private var dragOffset = CGSize.zero
  @State private var degreeOffset:Double = 0
  @State private var cardColor = Color("SubColor")
  
  var Colors = [Color("SubColor"), Color("SecondSubColor")]

    var body: some View {
          ZStack {
            Rectangle()
              .foregroundColor(cardColor)
              .frame(width: UIScreen.main.bounds.width * 0.9, height: 500, alignment: .center)
              
              .cornerRadius(8)
            .border(Color.black)
            
              
            Text(self.onCard ? card.sourceText : card.translateText)
              .transition(.opacity)
          }
          .offset(x: self.dragOffset.width)
          .scaleEffect(abs(dragOffset.width) > 100 ? 0.8 : 1)
          .rotation3DEffect(.degrees(self.onCard ? 180 : 1), axis: (x: 0, y: self.onCard ? 0 : 1, z: 0))
          .rotationEffect(.init(degrees: degreeOffset))
          .onTapGesture {
            self.onCard.toggle()
            self.cardColor = self.onCard ? self.Colors[0] : self.Colors[1]
          }
          .gesture(DragGesture()
            .onChanged { value in
              if value.translation.width > 0 {
                if value.translation.width > 30 {
                  self.dragOffset = value.translation
                  self.degreeOffset = 12
                  self.cardColor = .green
                } else {
                  self.dragOffset = value.translation
                  self.degreeOffset = 0
                }
              } else {
                if value.translation.width < -30 {
                  self.dragOffset = value.translation
                  self.degreeOffset = -12
                  self.cardColor = .red
                } else {
                  self.dragOffset = value.translation
                  self.degreeOffset = 0
                }
              }

            }
            .onEnded { value in
              self.degreeOffset = 0
              if self.dragOffset.width > UIScreen.main.bounds.width / 2.5 {
                self.dragOffset.width = CGFloat(500)
              } else if self.dragOffset.width < -UIScreen.main.bounds.width / 2.5 {
                self.dragOffset.width = -500
              } else {
                self.dragOffset = .zero
                self.cardColor =  self.onCard ? self.Colors[0] : self.Colors[1]
              }

          })
      
    }
}

struct ClickCard_Previews: PreviewProvider {
    static var previews: some View {
      ClickCard(card: Cards.init())
    }
}
