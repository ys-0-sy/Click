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
  @State private var detectedLanguage: String = "Initializing"
  @State var surpportedLanguages = TranslationManager.shared.supportedLanguages
  @State private var languageSelection = "ja"
  @State private var translatedText: String = "Enter Text"
 
  var body: some View {
    VStack {
    VStack {
      NavigationView {
        Form {
          Picker(selection: $languageSelection, label: Text("language")) {
            ForEach(TranslationManager.shared.supportedLanguages, id: \.self) { language in
              Text(language.name!).tag(language.code!)
            }
          }
        }
      }
    }
    VStack {
      Text(String(TranslationManager.shared.supportedLanguages.count))

      MultilineTextField(text: $myData.text)
      .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
      .overlay(
          RoundedRectangle(cornerRadius: 10)
              .stroke(Color.blue, lineWidth: 5)
      )
      
      HStack {
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
        Text("DetectLanguage")
      }
        Divider()

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
      }
      Text(detectedLanguage)
      Card(text:  $translatedText)
      .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
      Spacer()
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
