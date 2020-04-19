//
//  NavViewRouter.swift
//  Memolation
//
//  Created by saito on 2020/04/04.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class NavViewRouter: ObservableObject {
  @Published var currentView = "translation"

}

final class UserData: ObservableObject {
  @Published var rawText: String = ""
  var translatedText: String = "Enter Text"
  @Published var targetLanguageSelection = TranslationLanguage(language: "ja", name: "Japanese")
  @Published var surpportedLanguages = TranslationManager.shared.supportedLanguages

  init() {
    return
  }
  
  func translate() {
    TranslationManager.shared.targetLanguageCode = targetLanguageSelection.language
    TranslationManager.shared.textToTranslate = rawText
    
    TranslationManager.shared.translate(completion: {(returnString) in
      
      if let returnString = returnString {
        self.translatedText = returnString
      } else {
        self.translatedText = "translation error"
      }

    })
    print(self.rawText)
    print(self.translatedText)

  }
}
