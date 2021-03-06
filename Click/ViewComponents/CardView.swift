//
//  CardView.swift
//  Memolation
//
//  Created by saito on 2020/03/27.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import Combine

struct CardView: View {
  let text: String
  let width: CGFloat
  let height: CGFloat
  let alignment: Alignment
  let boarderColor: Color

  var body: some View {
      Text(self.text)
        .lineLimit(nil)
        .padding(.all)
        .frame(width: width, height: height, alignment: alignment)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(6)
        .overlay(
          RoundedRectangle(cornerRadius: 6)
            .stroke(boarderColor, lineWidth: 2)
        )

  }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
      CardView(
        text: "test", width: 200, height: 200,
        alignment: .topLeading,
        boarderColor: Color("SecondBaseColor"))
        .shadow(color: Color("shade"), radius: 20, x: 0, y: 5)
        .background(Color.white)
      .previewLayout(.sizeThatFits)
  }
}
