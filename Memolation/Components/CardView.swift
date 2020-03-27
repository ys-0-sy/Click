//
//  CardView.swift
//  Memolation
//
//  Created by saito on 2020/03/27.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct CardView: View {
  
    @State var text: String
    var body: some View {
        Text(text)
            .lineLimit(nil)
            .frame(width: UIScreen.main.bounds.width * 0.8, height: 200, alignment: .topLeading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple, lineWidth: 5)
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
      
      CardView(text: "text")
    }
}
