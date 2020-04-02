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
  @State var current:String = "t"
  var body: some View {
    Card(text: $current)
  }
}

struct Card: View {
    @Binding var text: String
  
    var body: some View {
      ZStack {
        Text(self.text)
        .lineLimit(nil)
        .frame(alignment: .topLeading)
      RoundedRectangle(cornerRadius: 10)
            .stroke(Color.purple, lineWidth: 5)
      }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
      CardView()
    }
}