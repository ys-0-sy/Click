//
//  ButtonView.swift
//  Memolation
//
//  Created by saito on 2020/04/08.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
  let buttonAction: () -> Void
  let text: String
    var body: some View {
        Button(action: buttonAction) {
          Text(text)
          .foregroundColor(Color.black)
        }
      .padding(.all)
      .background(Color("SubColor"))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonAction: {}, text: "text")
    }
}
