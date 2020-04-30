//
//  ListView.swift
//  Cl!ck
//
//  Created by saito on 2020/04/29.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI


struct ListView: View {
  @ObservedObject var card: Cards
    var body: some View {
      HStack {
        Spacer()
          .frame(width: 10)
        VStack(alignment: .leading) {
          Text(card.sourceText)
          .fixedSize()
          Text(card.translateText)
          .fixedSize()
        }
        Spacer()
        Divider()

        VStack {
          Text(card.sourceLanguage)
            .font(.subheadline)
            .lineLimit(nil)
            .fixedSize()
            .padding(.leading)
            .padding(.trailing)
            .background(Color("SubColor"))
            .cornerRadius(10)
          Spacer()
          Text(card.translateLanguage)
            .font(.subheadline)
            .lineLimit(nil)
            .fixedSize()
            .padding(.leading)
            .padding(.trailing)
            .background(Color("SecondSubColor"))
            .cornerRadius(10)
        }
        .padding(.horizontal)
        .frame(width: 100)
      }
       
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
     Text("Sample")
    }
}
