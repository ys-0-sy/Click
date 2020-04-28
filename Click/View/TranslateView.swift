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
      ScrollView(showsIndicators: false) {
        VStack(alignment: .center, spacing: 10) {
          VStack(alignment: .center, spacing: 10) {
          VStack(alignment: .leading, spacing: 20) {
          Text("Translation")
            .font(.largeTitle)
            .padding()
          HStack(alignment: .center, spacing: 23) {
            ButtonView(buttonAction: {
              self.viewModel.showSourceLanguageSelectionView = true
            },
               backGroundColor: Color("SubColor"),
               text: viewModel.sourceLanguageSelection?.name ?? "Auto Detect\n\(viewModel.detectionLanguage?.name ?? "")"
            )
              .sheet(isPresented:  self.$viewModel.showSourceLanguageSelectionView) {
              VStack {
                HStack {
                  Text("Source Language")
                  ButtonView(buttonAction: {self.viewModel.showSourceLanguageSelectionView = false},
                    backGroundColor: Color("SubColor"),
                    text: "Back")
                }.padding()
                Divider()
                List {
                  Button(action: {
                    self.viewModel.apply(inputs: .tappedSourceLanguageSelection(language: nil))

                  }) {
                    Text("Auto Detect")
                  }
                  ForEach(self.viewModel.surpportedLanguages, id: \.self) { language in
                    Button(action: {
                      print("tapped")
                      self.viewModel.apply(inputs: .tappedSourceLanguageSelection(language: language)) }) {
                      Text(language.name)
                    }
                  }
                }
              }
            }

            Image(systemName: "arrow.right.arrow.left")
            ButtonView(buttonAction: {
                self.viewModel.showTargetLanguageSelectionView = true
              },
                         backGroundColor: Color("SecondSubColor"),
                         text: viewModel.targetLanguageSelection.name
              )
              .sheet(isPresented: self.$viewModel.showTargetLanguageSelectionView) {
                VStack {
                  HStack {
                    Text("Target Language")
                    ButtonView(buttonAction: {self.viewModel.showTargetLanguageSelectionView = false},
                      backGroundColor: Color("SecondSubColor"),
                      text: "Back")
                  }.padding()
                  Divider()
                  List {
                    ForEach(self.viewModel.surpportedLanguages, id: \.self) { language in
                      Button(action: { self.viewModel.apply(inputs: .tappedDetectedLanguageSelection(language: language)) }) {
                        Text(language.name)
                      }
                    }
                  }
                }
              }
            }.frame(width: UIScreen.main.bounds.width * 0.9)
          }.frame(alignment: .leading)
          
          MultilineTextField(text: $viewModel.sourceText, onEditingChanged: update)
            .padding()
            .frame(
              width: UIScreen.main.bounds.width * 0.85,
              height: UIScreen.main.bounds.height * 0.15,
              alignment: .topLeading
            )
            
            .background(Color(UIColor.systemBackground))
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                  .stroke(Color("SubColor"), lineWidth: 2)
            )
            Spacer()
          CardView(
            text: viewModel.translatedText,
            width: UIScreen.main.bounds.width * 0.85,
            height: UIScreen.main.bounds.height * 0.15,
            alignment: .topLeading,
            boarderColor: Color("SecondSubColor")
          )
            Rectangle()
              .foregroundColor(Color(.systemGray6))
              .frame(height: 10)
          }
          .frame(width: UIScreen.main.bounds.width * 0.95)
          .background(Color(UIColor.systemGray6))
          .cornerRadius(20)
           
        }
          

        .frame(maxWidth: .infinity)
      }
      
      .onTapGesture {
        UIApplication.shared.closeKeyboard()
        self.viewModel.apply(inputs: .onCommitText(text: self.viewModel.sourceText))
      }
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
