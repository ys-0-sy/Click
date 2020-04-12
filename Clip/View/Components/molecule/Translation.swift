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
  @ObservedObject(initialValue: .init()) var viewModel: UserData
    var body: some View {
        HStack(alignment: .center, spacing: 23) {
          ButtonView(
            buttonAction: {TranslationManager.shared.detectLanguage(forText: self.myData.rawText, completion: {(language) in
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
              ChooseLanguages(showAfterView: $showAfterView, languageSelection: $myData.targetLanguageSelection)
            }
            .navigationBarHidden(true)
          .navigationBarBackButtonHidden(true), isActive: $showAfterView) {
              ButtonView(buttonAction: {self.showAfterView = true},
            backGroundColor: Color("SecondSubColor"),
            text: self.myData.targetLanguageSelection.name
            )
          }
          Button(action: {self.viewModel.translate()}) {
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
