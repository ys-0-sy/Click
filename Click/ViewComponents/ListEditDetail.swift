//
//  EditDetail.swift
//  Cl!ck
//
//  Created by saito on 2020/05/26.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct ListEditDetail: View {
  let card: Card
  let width: CGFloat
  @Binding var sourceText: String
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
            TextField(card.sourceText, text: $sourceText)
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
          } else {
            Text("Clicked")
              .font(.caption)
              .frame(width: 100)
              .background(Color("SubColor"))
              .rotationEffect(.degrees(45))
              .offset(x: UIScreen.main.bounds.width * 6/16, y: -25)
          }
        }
      }
  }
}

struct ListEditDetail_Previews: PreviewProvider {
  @State var text = "text"
    static var previews: some View {
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      let newCard = Card(context: context)
      newCard.isRemembered = false
      newCard.sourceLanguage = "English"
      newCard.sourceText = "Text"
      newCard.translateText = "テキスト"
      newCard.translateLanguage = "Japanese"
      return ListEditDetail(card: newCard, width: UIScreen.main.bounds.width, sourceText: .constant("text"))
        .previewLayout(.fixed(width: UIScreen.main.bounds.width * 0.9, height: 100))
    }
}
