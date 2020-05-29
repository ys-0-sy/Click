//
//  ListView.swift
//  Cl!ck
//
//  Created by saito on 2020/04/29.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI


struct ListView: View {
  let card: Card
  let width: CGFloat
    var body: some View {
      ZStack {
      HStack(alignment: .top, spacing: 0) {
          VStack(alignment: .center, spacing: 0) {
            Spacer()
              .frame(height: 10)
            Text(card.sourceLanguage)
              .font(.subheadline)
              .fixedSize()
              .padding(.leading)
              .padding(.trailing)
              .background(Color("SubColor"))
              .cornerRadius(10)
            Spacer()
              .frame(height: 10)
            Text(card.sourceText)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(nil)
            Spacer()
              .frame(height: 10)
          }
          .padding()
          .frame(width: self.width/2)
        
           Divider()
            .padding(.vertical)
          VStack(alignment: .center, spacing: 0) {
            Spacer()
              .frame(height: 10)
            Text(card.translateLanguage)
              .font(.subheadline)
            .fixedSize()
              .padding(.leading)
              .padding(.trailing)
              .background(Color("SecondSubColor"))
              .cornerRadius(10)
            Spacer()
              .frame(height: 10)
            Text(card.translateText)
              .fixedSize(horizontal: false, vertical: true)
            .lineLimit(nil)
            Spacer()
              .frame(height: 10)
          }
          
          .padding()
          .frame(width: self.width/2)
        }
        Group {
          if self.card.isRemembered {
            Text("Clicked")
              .font(.caption)
              .frame(width: 100)
              .background(Color("SubColor"))
              .rotationEffect(.degrees(45))
              .offset(x: UIScreen.main.bounds.width * 6/16, y: -25)
          }
        }
      }
      .frame(width: self.width, alignment: .center)
      .cornerRadius(6)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
     Text("Sample")
    }
}
