//
//  NavigatinButtonView.swift
//  Memolation
//
//  Created by saito on 2020/04/09.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct NavigatinButtonView: View {
  let width: CGFloat
  let image: String
  let text: String
    var body: some View {
        VStack {
          Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(8)
            .frame(width: width, height: 60)
          Text(text)
          .font(.footnote)
          .offset(y: -14)
        }
    }
}

struct NavigatinButtonView_Previews: PreviewProvider {
    static var previews: some View {
      NavigatinButtonView(width: 60, image: "settings", text: "Settings")
    }
}
