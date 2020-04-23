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
  @ObservedObject var viewModel: TranslateViewModel
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .center, spacing: 30) {
          Text("Translation")
            .font(.title)
          HStack(alignment: .center, spacing: 23) {
            NavigationLink(destination:
              VStack {
                HStack {
                  Text("Source Language")
                  ButtonView(buttonAction: {self.viewModel.showSourceLanguageSelectionView = false},
                    backGroundColor: Color("SubColor"),
                    text: "Back")
                }
                List {
                  Button(action: {
                    self.viewModel.apply(inputs: .tappedSourceLanguageSelection(language: nil))
                    
                  }) {
                    Text("Auto Detect")
                  }
                  ForEach(viewModel.surpportedLanguages, id: \.self) { language in
                    Button(action: {
                      print("tapped")
                      self.viewModel.apply(inputs: .tappedSourceLanguageSelection(language: language)) }) {
                      Text(language.name)
                    }
                  }
                }
              },
                           isActive: self.$viewModel.showSourceLanguageSelectionView) {
                ButtonView(buttonAction: {
                  self.viewModel.showSourceLanguageSelectionView = true
                },
                   backGroundColor: Color("SubColor"),
                   text: viewModel.sourceLanguageSelection?.name ?? "Auto Detect\n  \(viewModel.detectionLanguage?.name ?? "")"
                )
              }
            Image(systemName: "arrow.right.arrow.left")
            NavigationLink(destination:
              VStack {
                ButtonView(buttonAction: {self.viewModel.showTargetLanguageSelectionView = false},
                  backGroundColor: Color("SecondSubColor"),
                  text: "Back")
                List {
                  ForEach(viewModel.surpportedLanguages, id: \.self) { language in
                    Button(action: { self.viewModel.apply(inputs: .tappedDetectedLanguageSelection(language: language)) }) {
                      Text(language.name)
                    }
                  }
                }
              },
                           isActive: self.$viewModel.showTargetLanguageSelectionView) {
                ButtonView(buttonAction: {
                  self.viewModel.showTargetLanguageSelectionView = true
                },
                           backGroundColor: Color("SecondSubColor"),
                           text: viewModel.targetLanguageSelection.name
                )
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
        .background(Color(UIColor.systemBackground))
          .frame(maxWidth: UIScreen.main.bounds.width * 0.95)
        .cornerRadius(10)
          

        Spacer().frame(height: 50)
      }
      .frame(maxWidth: .infinity)
      .background(Color("SubColor"))
      .onTapGesture {
        UIApplication.shared.closeKeyboard()
        self.viewModel.apply(inputs: .onCommitText(text: self.viewModel.sourceText))
      }
    }
    
    .background(Color("SubColor"))
    .navigationBarHidden(true)
    .navigationBarTitle("")
    .edgesIgnoringSafeArea(.top)

  }
  
  func update(changed: Bool) {
    guard !changed else { return }
  }

}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct TranslateView_Previews: PreviewProvider {
    static var previews: some View {
      TranslateView(viewModel: .init(apiService: APIService()))
    }
}
