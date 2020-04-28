//
//  HistoryView.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
  let text: String
  let width: CGFloat
  let height: CGFloat
  let alignment: Alignment
  let boarderColor: Color
    var body: some View {
      HStack(alignment: .center) {
        Text(self.text)
        .lineLimit(nil)
        .padding(.all)
        Divider()
        Text(self.text)
        .lineLimit(nil)
        .padding(.all)
      }
    .padding()
      .frame(width: width, height: height)
      .background(Color(UIColor.systemBackground))
      .cornerRadius(6)
      .overlay(
          RoundedRectangle(cornerRadius: 6)
              .stroke(boarderColor, lineWidth: 2)
      )
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(
          text: "test", width: 200, height: 200,
          alignment: .center,
          boarderColor: Color("SecondBaseColor"))
          .background(Color.white)
        .previewLayout(.sizeThatFits)
    }
}
