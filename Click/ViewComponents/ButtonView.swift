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
  let backGroundColor: Color
  let text: String

  var body: some View {
    Button(action: buttonAction) {
      Text(text)
      .padding(5)
      .multilineTextAlignment(.center)
    }
      .foregroundColor(Color.black)
      .padding(.horizontal)
      .background(backGroundColor)
      .cornerRadius(30)
      
  }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(
          buttonAction: {},
          backGroundColor: Color("SubColor"), text: "tex\nt"
      )
          .previewLayout(.sizeThatFits)
  }
}
