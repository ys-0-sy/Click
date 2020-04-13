//
//  TranslateView.swift
//  Memolation
//
//  Created by saito on 2020/03/27.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import Combine

struct TranslateView: View {
  @State private var showAfterView: Bool = false
  @ObservedObject var viewModel: TranslateViewModel
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .center, spacing: 30) {
          Text("Translation")
            .font(.title)
          Translation()
          MultilineTextField(text: $viewModel.sourceText, onEditingChanged: update)
            .padding()
            .frame(
              width: UIScreen.main.bounds.width * 0.9,
              height: UIScreen.main.bounds.height * 0.2,
              alignment: .topLeading
            )
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                  .stroke(Color("BaseColor"), lineWidth: 4)
            )

          CardView(
            text: viewModel.translatedText,
            width: UIScreen.main.bounds.width * 0.9,
            height: UIScreen.main.bounds.height * 0.2,
            alignment: .topLeading,
            boarderColor: Color("SecondBaseColor")
          )

          Spacer()
          CardView(
            text: viewModel.sourceText,
            width: UIScreen.main.bounds.width * 0.9,
            height: 200,
            alignment: .topLeading, boarderColor: .white
          )
            .shadow(color: Color("shade"), radius: 20, x: 0, y: 5)
            .background(Color.white)
          Rectangle()
            .foregroundColor(Color("SubColor"))
            .frame( height: 50)
        }
          .frame(maxWidth: .infinity)
          .background(Color.white)
        Rectangle()
          .foregroundColor(Color("SubColor"))
          .frame( height: 50)
      }
      .background(Color("SubColor"))
    }
    .navigationBarHidden(true)
    .navigationBarTitle("")
    .edgesIgnoringSafeArea(.top)
  }
  
  func update(changed: Bool) {
      guard !changed else { return }
      //document.content = content
      //document.updateChangeCount(.done)
  }

}

struct TranslateView_Previews: PreviewProvider {
    static var previews: some View {
      TranslateView(viewModel: .init(apiService: APIService()))
    }
}
