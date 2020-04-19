//
//  SwiftUIView.swift
//  Memolation
//
//  Created by saito on 2020/04/02.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import Combine

struct ChooseLanguagesView: View {
  @State private var showAfterView: Bool = false
  @ObservedObject private var myData = UserData()
  
  var body: some View {
    ChooseLanguages(showAfterView: $showAfterView, languageSelection: $myData.targetLanguageSelection)
  }
}

struct ChooseLanguages: View {
  @Binding var showAfterView: Bool
  @Binding var languageSelection: TranslationLanguage
  var body: some View {
    List {
      ForEach(TranslationManager.shared.supportedLanguages, id: \.self) { language in
        Button(action: {
          self.showAfterView = false
          self.languageSelection = language
        }) {
          Text(language.name)
        }
      }
    }
    .navigationBarHidden(false)
  }
}

struct ChooseLanguages_Previews: PreviewProvider {
    static var previews: some View {
         ChooseLanguagesView()
    }
}
