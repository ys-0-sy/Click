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
  @ObservedObject private var myData = UserData()
  @State private var detectedLanguage: String = "Auto Detect"
  @State var surpportedLanguages = TranslationManager.shared.supportedLanguages
  @State private var languageSelection = "ja"
  @State private var translatedText: String = "Enter Text"
 
  var body: some View {
    NavigationView {
      VStack {
        Button(action: {TranslationManager.shared.detectLanguage(forText: self.myData.text, completion: {(language) in
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
        })}) {
          Text(detectedLanguage)
        }
        MultilineTextField(text: $myData.text)
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 5)
        )
        NavigationLink(destination: ChooseLanguages()) {
          Text("Target Language")
        }
        Card(text:  $translatedText)
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
        
        Button(action: {
          TranslationManager.shared.targetLanguageCode = self.languageSelection
          TranslationManager.shared.textToTranslate = self.myData.text
          TranslationManager.shared.translate(completion: {(returnString) in
            if let returnString = returnString  {
              self.translatedText = returnString
            } else {
              self.translatedText = "translation error"
            }
           
          })
        }) {
          Text("Translate")
        }
        Spacer()
        Card(text: $myData.text)
          .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
      }.onTapGesture {
        self.endEditing()
      }
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
