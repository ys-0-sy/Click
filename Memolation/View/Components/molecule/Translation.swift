//
//  Translation.swift
//  Memolation
//
//  Created by saito on 2020/04/10.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct Translation: View {
  @State private var showAfterView: Bool = false
  @ObservedObject private var myData = UserData()
  @State private var detectedLanguage: String = "Auto Detect"
  @State private var languageSelection = TranslationLanguage(code: "ja", name: "Japanese")

    var body: some View {
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
          Image(systemName: "arrow.right.arrow.left")
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
        Button(action: {
          TranslationManager.shared.targetLanguageCode = self.languageSelection.code!
          TranslationManager.shared.textToTranslate = self.myData.text
          TranslationManager.shared.translate(completion: {(returnString) in
            if let returnString = returnString {
              self.myData.translatedText = returnString
            } else {
              self.myData.translatedText = "translation error"
            }

          })
        }) {
          Text("Translate")
        }
        }.frame(width:UIScreen.main.bounds.width * 0.9)
    }
}

struct Translation_Previews: PreviewProvider {
    static var previews: some View {
        Translation()
    }
}
