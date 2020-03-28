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
 
  var body: some View {
    VStack {
      MultilineTextField(text: $myData.text)
      .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
      .overlay(
          RoundedRectangle(cornerRadius: 10)
              .stroke(Color.blue, lineWidth: 5)
      )
      Button(action: {TranslationManager.shared.detectLanguage(forText: self.myData.text, completion: {(language) in
        if let language = language {
          self.detectedLanguage = language
        } else {
          self.detectedLanguage = "Oops! It seems that something went wrong and language cannot be detected."
        }
      })}) {
        Text("DetectLanguage")
      }
      Text(detectedLanguage)
      Spacer()
      Card(text: $myData.text)
      .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
      Spacer()
    }
  }
}

struct TranslateView_Previews: PreviewProvider {
    static var previews: some View {
        TranslateView()
    }
}
