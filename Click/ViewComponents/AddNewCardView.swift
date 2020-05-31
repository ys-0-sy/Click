//
//  AddNewCardView.swift
//  Cl!ck
//
//  Created by saito on 2020/05/29.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct AddNewCardView: View {
  @State private var sourceText: String = ""
  @State private var targetText: String = ""
  @ObservedObject var viewModel: TranslateViewModel
  @State private var sourceLanguageSelection = TranslationLanguage(language: "", name: "")
  @State private var targetLanguageSelection = TranslationLanguage(language: "", name: "")
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  init() {
    self.viewModel = TranslateViewModel()
  }
  var body: some View {
    VStack(alignment: .leading) {
      Text("New Card")
        .font(.title)
        .fontWeight(.bold)
        .padding(.vertical)
      VStack(spacing: 40) {
        HStack {
          Button(action: {self.viewModel.showSourceLanguageSelectionView = true}) {
            if sourceLanguageSelection.name == "" {
              Text("Select Language")
                .fontWeight(.bold)
              .fixedSize()
            } else {
              Text(sourceLanguageSelection.name)
              .fontWeight(.bold)

            }
          }
          .sheet(isPresented: self.$viewModel.showSourceLanguageSelectionView) {
            VStack {
              HStack {
                Spacer()
                Text("Translate From")
                .foregroundColor(Color("BaseColor"))

                Spacer()
                Button(action: {self.viewModel.showSourceLanguageSelectionView = false}) {
                  Image(systemName: "xmark")
                    .foregroundColor(Color("BaseColor"))
                }
              }.padding()
              Divider()
              List {
                Section(header: Text("Recently")) {
                  ForEach(self.viewModel.languageHistory, id: \.self) { language in
                    Button(action: {
                      self.sourceLanguageSelection = language
                      self.viewModel.showSourceLanguageSelectionView = false
                    }) {
                       Text(language.name)
                     }
                  }
                }
                Section(header: Text("All Languages")) {
                  ForEach(self.viewModel.surpportedLanguages, id: \.self) { language in
                    Button(action: {
                      self.sourceLanguageSelection = language
                      self.viewModel.showSourceLanguageSelectionView = false
                    }) {
                      Text(language.name)
                    }
                  }
                }
              }.listStyle(GroupedListStyle())
            }
          }
          .accentColor(Color(.white))
          .padding(.vertical, 8)
          .frame(width: UIScreen.main.bounds.width * 0.85 / 2.2)
          .background(Color("SubColor"))
          .cornerRadius(10)
          Spacer()
          Button(action: {self.viewModel.showTargetLanguageSelectionView = true}) {
            if self.targetLanguageSelection.name == "" {
              Text("Select Language")
                .fontWeight(.bold)

              .fixedSize()
            } else {
              Text(self.targetLanguageSelection.name)
              .fontWeight(.bold)

            }
          }
            .sheet(isPresented: self.$viewModel.showTargetLanguageSelectionView) {
               VStack {
                 HStack {
                   Spacer()
                   Text("Translate To")
                   .foregroundColor(Color("BaseColor"))

                   Spacer()
                   Button(action: {self.viewModel.showTargetLanguageSelectionView = false}) {
                     Image(systemName: "xmark")
                       .foregroundColor(Color("BaseColor"))
                   }
                 }.padding()
                 Divider()
                 List {
                   Section(header: Text("Recently")) {
                     ForEach(self.viewModel.languageHistory, id: \.self) { language in
                       Button(action: {
                         self.targetLanguageSelection = language
                         self.viewModel.showTargetLanguageSelectionView = false
                       }) {
                          Text(language.name)
                        }
                     }
                   }
                   Section(header: Text("All Languages")) {
                    ForEach(self.viewModel.surpportedLanguages, id: \.self) { language in
                       Button(action: {
                        self.targetLanguageSelection = language
                         self.viewModel.showTargetLanguageSelectionView = false
                       }) {
                        Text(language.name)
                       }
                     }
                   }
                 }.listStyle(GroupedListStyle())
               }
          }
          
          .accentColor(Color(.white))
          .padding(.vertical, 8)
          .frame(width: UIScreen.main.bounds.width * 0.85 / 2.2)
          .background(Color("SecondSubColor"))
          .cornerRadius(10)
        }
        .padding(.top, UIScreen.main.bounds.width * 0.05)
        .frame(width:UIScreen.main.bounds.width * 0.85)
        MultilineTextField("Translate from", text: $sourceText)
          .padding()
          .frame(
            width: UIScreen.main.bounds.width * 0.85,
            height: UIScreen.main.bounds.height * 0.15,
            alignment: .topLeading
          )
          
          .background(Color(UIColor.systemBackground))
          .cornerRadius(6)
          .overlay(
            ZStack(alignment: .topTrailing) {
              RoundedRectangle(cornerRadius: 6)
                .stroke(Color("SubColor"), lineWidth: 2)
              Group {
                if !self.sourceText.isEmpty {
                Button(action: {
                  self.sourceText = ""
                }) {
                  Image(systemName: "xmark")
                  .padding()
                }
                } else {
                  Button(action: {
                    self.sourceText = UIPasteboard.general.string ?? ""
                  }) {
                    Image(systemName: "doc.on.clipboard")
                    .padding()
                  }
                }
              }

            }
          )
        MultilineTextField("Translate to", text: $targetText)
        .padding()
        .frame(
          width: UIScreen.main.bounds.width * 0.85,
          height: UIScreen.main.bounds.height * 0.15,
          alignment: .topLeading
        )
        
        .background(Color(UIColor.systemBackground))
        .cornerRadius(6)
        .overlay(
          ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 6)
              .stroke(Color("SecondSubColor"), lineWidth: 2)
            Group {
              if !self.targetText.isEmpty {
              Button(action: {
                self.targetText = ""
              }) {
                Image(systemName: "xmark")
                .padding()
              }
              } else {
                Button(action: {
                  self.targetText = UIPasteboard.general.string ?? ""
                }) {
                  Image(systemName: "doc.on.clipboard")
                  .padding()
                }
              }
            }

          }
        )
        Spacer()
        HStack {
          Button(action: {
            if !self.sourceLanguageSelection.name.isEmpty && !self.targetLanguageSelection.name.isEmpty &&
              !self.sourceText.isEmpty && !self.targetText.isEmpty {
              Card.create(sourceLanguage: self.sourceLanguageSelection, sourceText: self.sourceText, targetLanguage: self.targetLanguageSelection, translateText: self.targetText)
              self.sourceText = ""
              self.targetText = ""
            }
          }) {
            Text("Add Others")
              .fontWeight(.bold)
              .foregroundColor(Color(.white))
            .padding()
              .frame(width: UIScreen.main.bounds.width * 1/2.7)
            .background(
            RoundedRectangle(cornerRadius: 6)
              .foregroundColor(Color("SubColor"))
              //.stroke(Color.green, lineWidth: 3)
            )
          }
          Spacer()
          Button(action: {
            if !self.sourceLanguageSelection.name.isEmpty && !self.targetLanguageSelection.name.isEmpty &&
              !self.sourceText.isEmpty && !self.targetText.isEmpty {
              Card.create(sourceLanguage: self.sourceLanguageSelection, sourceText: self.sourceText, targetLanguage: self.targetLanguageSelection, translateText: self.targetText)
              self.mode.wrappedValue.dismiss()
            }
          }) {
            Text("Create")
              .fontWeight(.bold)
              .foregroundColor(Color(.white))
              .padding()
              .frame(width: UIScreen.main.bounds.width * 1/2.7)
              .background(
                RoundedRectangle(cornerRadius: 6)
                .foregroundColor(Color("SubColor"))
              )
            
          }
        .disabled(true)
        }
        .frame(width: UIScreen.main.bounds.width * 0.85)

      Spacer()
      }
      .frame(width: UIScreen.main.bounds.width * 0.95)
      .background(Color(UIColor.systemGray6))
      .cornerRadius(8)
    }
    .padding(.bottom)

  }
}

struct AddNewCardView_Previews: PreviewProvider {
    static var previews: some View {
      AddNewCardView()
    }
}
