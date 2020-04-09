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
  @State private var detectedLanguage: String = "Auto Detect"
  @State var surpportedLanguages = TranslationManager.shared.supportedLanguages
  @State private var languageSelection = TranslationLanguage(code: "ja", name: "Japanese")
  @State private var translatedText: String = "Enter Text"
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .center, spacing: 10) {
          HStack(alignment: .center, spacing: 23) {
            ButtonView(
              buttonAction: {TranslationManager.shared.detectLanguage(forText: self.myData.text, completion: {(language) in
              if let language = language {
                self.detectedLanguage = language
                for lang in TranslationManager.shared.supportedLanguages {
                  if lang.code == language {
                    self.detectedLanguage = lang.name ?? language
                  }
                }

              } else {
                self.detectedLanguage = "Oops! It seems that something went wrong and language cannot be detected."
              }
            })}
            ,
            backGroundColor:Color("SubColor"),
            text: detectedLanguage
            )
            Image(systemName: "arrow.right")
            NavigationLink(destination:
              VStack {
                ButtonView(buttonAction: {self.showAfterView = false},
                  backGroundColor: Color("SecondSubColor"),
                  text: "Back")
                ChooseLanguages(showAfterView: $showAfterView, languageSelection: $languageSelection)
              }
            .navigationBarBackButtonHidden(true), isActive: $showAfterView) {
                ButtonView(buttonAction: {self.showAfterView = true},
              backGroundColor: Color("SecondSubColor"),
              text: self.languageSelection.name!
              )
            }
          }.frame(width:UIScreen.main.bounds.width * 0.9)
        MultilineTextField(text: $myData.text)
          .padding()
          .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.2, alignment: .topLeading)
          .background(Color.white)
          .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(Color("BaseColor"), lineWidth: 4)
          )

        CardView(
          text: translatedText,
          width: UIScreen.main.bounds.width * 0.9,
          height: UIScreen.main.bounds.height * 0.2,
          alignment: .topLeading,
          boarderColor: Color("SecondBaseColor"))

        Button(action: {
          TranslationManager.shared.targetLanguageCode = self.languageSelection.code!
          TranslationManager.shared.textToTranslate = self.myData.text
          TranslationManager.shared.translate(completion: {(returnString) in
            if let returnString = returnString {
              self.translatedText = returnString
            } else {
              self.translatedText = "translation error"
            }

          })
        }) {
          Text("Translate")
        }
        Spacer()
        CardView(
          text: myData.text,
          width: UIScreen.main.bounds.width * 0.9,
          height: 200,
          alignment: .topLeading, boarderColor: .white)
          .shadow(color: Color("shade"), radius: 20, x: 0, y: 5)
          .background(Color.white)

          
      }.onTapGesture {
        self.endEditing()
        }.frame(maxWidth: .infinity)
      }
      .navigationBarTitle("Translation")
      .navigationBarHidden(false)
    }
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
