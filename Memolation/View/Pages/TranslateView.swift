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
  @ObservedObject private var myData = UserData()
  @State var surpportedLanguages = TranslationManager.shared.supportedLanguages
  
  var body: some View {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .center, spacing: 10) {
          Text("Translation")
            .font(.title)
        Translation()
        MultilineTextField(text: $myData.text)
          .padding()
          .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2, alignment: .topLeading)
          .background(Color.white)
          .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(Color("BaseColor"), lineWidth: 4)
          )

        CardView(
          text: myData.translatedText,
          width: UIScreen.main.bounds.width * 0.9,
          height: UIScreen.main.bounds.height * 0.2,
          alignment: .topLeading,
          boarderColor: Color("SecondBaseColor"))


        Spacer()
        CardView(
          text: myData.text,
          width: UIScreen.main.bounds.width * 0.9,
          height: 200,
          alignment: .topLeading, boarderColor: .white)
          .shadow(color: Color("shade"), radius: 20, x: 0, y: 5)
          .background(Color.white)
          }
          .frame(maxWidth: .infinity)
          .background(Color.white)
          .onTapGesture {
              self.endEditing()
          }
      }.background(Color("SubColor"))
  }
  private func endEditing() {
      UIApplication.shared.endEditing()
  }

}

struct TranslateView_Previews: PreviewProvider {
    static var previews: some View {
        TranslateView()
    }
}
