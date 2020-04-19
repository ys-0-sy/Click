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
  @State private var detectedLanguage: String = "Auto Detect"
  @State private var showAfterView: Bool = false
  @ObservedObject var viewModel: TranslateViewModel
  @ObservedObject private var myData = UserData()
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .center, spacing: 30) {
          Text("Translation")
            .font(.title)
          HStack(alignment: .center, spacing: 23) {
            ButtonView(
              buttonAction: {TranslationManager.shared.detectLanguage(forText: self.myData.rawText, completion: {(language) in
              if let language = language {
                self.detectedLanguage = language
                for lang in TranslationManager.shared.supportedLanguages {
                  if lang.language == language {
                    self.detectedLanguage = lang.name
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
                List {
                  ForEach(viewModel.surpportedLanguages, id: \.self) { language in
                    Button(action: { self.viewModel.apply(inputs: .tappedLanguageSelection(language: language)) }) {
                      Text(language.name)
                    }
                  }
                }
              },
              isActive: $showAfterView) {
                ButtonView(buttonAction: {
                  self.showAfterView = true
                  self.viewModel.apply(inputs: .fetchLanguages)
                },
                           backGroundColor: Color("SecondSubColor"),
                           text: self.myData.targetLanguageSelection.name
                )
              }
            Button(action: {self.viewModel.apply(inputs: .fetchLanguages)}) {
            Text("Translate")
            }
          }.frame(width:UIScreen.main.bounds.width * 0.9)
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
