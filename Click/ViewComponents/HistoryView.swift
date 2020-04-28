//
//  HistoryView.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
  let sourceText: String
  let translationText: String
  let sourceLanguage: TranslationLanguage
  let translationLanguage: TranslationLanguage
  let width: CGFloat
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
          VStack(alignment: .center, spacing: 0) {
            Text(sourceLanguage.name)
              .font(.subheadline)
            .fixedSize()
              .padding(.leading)
              .padding(.trailing)
              .background(Color("SubColor"))
              .cornerRadius(10)
            Spacer()
              .frame(height: 20)
            Text(sourceText)
            .fixedSize(horizontal: false, vertical: true)
              .multilineTextAlignment(.center)
            .lineLimit(nil)
            Spacer()
              .frame(height: 10)
          }
          .padding()
          .frame(width: self.width/2)
          Divider()
            .frame(height: 80)
          VStack(alignment: .center, spacing: 0) {
            Text(translationLanguage.name)
              .font(.subheadline)
            .fixedSize()
              .padding(.leading)
              .padding(.trailing)
              .background(Color("SecondSubColor"))
              .cornerRadius(10)
            Spacer()
              .frame(height: 20)
            Text(translationText)
              .fixedSize(horizontal: false, vertical: true)
            .lineLimit(nil)
            Spacer()
              .frame(height: 10)
          }
          .padding()
          .frame(width: self.width/2)
        }
        .frame(minHeight: 100)
      .frame(width: self.width, alignment: .center)
      .cornerRadius(6)
  }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
      HistoryView(sourceText: "Poop", translationText: "うんち", sourceLanguage: TranslationLanguage(language: "en", name: "English"), translationLanguage: TranslationLanguage(language: "ja", name: "Japanese"), width: UIScreen.main.bounds.width)
        .previewLayout(.sizeThatFits)
    }
}
