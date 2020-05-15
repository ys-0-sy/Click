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
  
  init() {
    self.viewModel = TranslateViewModel()
  }
  
  var body: some View {
      ScrollView(showsIndicators: false) {
        VStack(alignment: .center, spacing: 10) {
          VStack(alignment: .center, spacing: 20) {
          VStack(alignment: .leading, spacing: 20) {
            Spacer()
              .frame(height: 1)
          HStack(alignment: .center, spacing: 23) {
            Button(action: {
              self.viewModel.showSourceLanguageSelectionView = true
            }) {
              Group {
                if viewModel.sourceLanguageSelection?.name != nil {
                  Text(self.viewModel.sourceLanguageSelection!.name)
                } else {
                  if self.viewModel.detectionLanguage?.name != nil {
                    VStack {
                    Text("Auto Detect")
                    Text("\(self.viewModel.detectionLanguage!.name)")
                    }
                  } else {
                    Text("Auto Detect")
                  }
                }
              }
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .accentColor(.black)
              .background(Capsule()
                .foregroundColor(Color("SubColor")))
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
                      Button(action: { self.viewModel.apply(inputs: .tappedSourceLanguageSelection(language: language)) }) {
                         Text(language.name)
                       }
                    }
                  }
                  Section(header: Text("All Languages")) {
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
                }.listStyle(GroupedListStyle())
              }
            }
            Group {
              if self.viewModel.sourceLanguageSelection == nil {
                Image(systemName: "arrow.right")
              } else {
                Button(action: {
                  self.viewModel.apply(inputs: .tappedLanguageSwitcher)
                }, label: {Image(systemName: "arrow.right.arrow.left")})
                
              }
              
            }
            
            Button(action: { self.viewModel.showTargetLanguageSelectionView = true } ) {
                Text(viewModel.targetLanguageSelection.name)
                  .foregroundColor(.black)
                  .padding(.horizontal)
                  .background(
                    Capsule()
                    .foregroundColor(Color("SecondSubColor"))
                  )

            }
              .sheet(isPresented: self.$viewModel.showTargetLanguageSelectionView) {
                VStack {
                  HStack {
                    Spacer()
                    Text("Translate To")
                    .foregroundColor(Color("SecondSubColor"))

                    Spacer()
                    Button(action: {self.viewModel.showTargetLanguageSelectionView = false}) {
                      Image(systemName: "xmark")
                        .foregroundColor(Color("SecondSubColor"))
                    }
                  }.padding()
                  Divider()
                  List {
                    Section(header: Text("Recently")) {
                      ForEach(self.viewModel.languageHistory, id: \.self) { language in
                        Button(action: { self.viewModel.apply(inputs: .tappedDetectedLanguageSelection(language: language)) }) {
                           Text(language.name)
                         }
                      }
                    }
                    Section(header: Text("All Languages")) {
                      ForEach(self.viewModel.surpportedLanguages, id: \.self) { language in
                        Button(action: { self.viewModel.apply(inputs: .tappedDetectedLanguageSelection(language: language)) }) {
                          Text(language.name)
                        }
                      }
                    }
                  }.listStyle(GroupedListStyle())
                  .accentColor(Color("SecondSubColor"))
                }
              }
            }.frame(width: UIScreen.main.bounds.width * 0.9)
          }.frame(alignment: .leading)
          
            MultilineTextField(text: $viewModel.sourceText, onCommit: {
              self.viewModel.apply(inputs: .onCommitText(text: self.viewModel.sourceText))
              print(self.viewModel.sourceText)
            })
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
                  if self.viewModel.sourceText != "" {
                  Button(action: {
                    self.viewModel.sourceText = ""
                  }) {
                    Image(systemName: "xmark")
                    .padding()
                  }
                  } else {
                    Button(action: {
                      self.viewModel.sourceText = UIPasteboard.general.string ?? ""
                      self.viewModel.apply(inputs: .onCommitText(text: self.viewModel.sourceText))
                    }) {
                      Image(systemName: "doc.on.clipboard")
                      .padding()
                    }
                  }
                }

              }
            )
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
          
          VStack(alignment: .leading, spacing: 20) {
            Text("History")
              .font(.title)
              .fontWeight(.bold)
              .padding(.top)
            ForEach(self.viewModel.cardsHistory, id: \.self) { card in
                HistoryView(card: card, width: UIScreen.main.bounds.width * 0.85)
                  .background(Color(UIColor.systemBackground))
                  .cornerRadius(8)
              }
            
            Spacer()
              .frame(height: 30)
          }
          
           .frame(width: UIScreen.main.bounds.width * 0.95)
           .background(Color(UIColor.systemGray6))
           .cornerRadius(20)
        }


        .frame(maxWidth: .infinity)
    }.navigationBarTitle("Translation")
  }
  
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct TranslateView_Previews: PreviewProvider {
    static var previews: some View {
      TranslateView()
    }
}
