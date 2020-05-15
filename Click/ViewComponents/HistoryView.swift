//
//  HistoryView.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
  let card: CardsHistory
  let width: CGFloat
    var body: some View {
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
        //.frame(minHeight: 100)
      .frame(width: self.width, alignment: .center)
      .cornerRadius(6)
  }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
      Text("hoge")
      //HistoryView(card: , width: UIScreen.main.bounds.width)
        .previewLayout(.sizeThatFits)
    }
}
