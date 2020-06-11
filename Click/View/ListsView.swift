//
//  ListsView.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import CoreData
import SwiftUIX

struct ListsView: View {
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.id, ascending: true)], animation: .default) var cards: FetchedResults<Card>
  @Environment(\.managedObjectContext) var viewContext
  @State var isEditMode: EditMode = .inactive
  @ObservedObject var model: ListViewModel
  @State private var searchText : String = ""
  @State private var onEdit = false
  @State private var sourceLanguageSelection = ""
  @State private var targetLanguageSelection = ""
  @ObservedObject var viewModel: TranslateViewModel
  
  private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  
  func sourceDuplicateEraser(array: FetchedResults<Card>) -> [String] {
    var set = Set<String>()
    _ = array.reduce(into: []) { tmp, element in
      guard !set.contains(element.sourceLanguage) else { return }
      set.insert(element.sourceLanguage)
      tmp.append(element.sourceLanguage)
    }
    return Array(set)
  }
  
  func targetDuplicateEraser(array: FetchedResults<Card>) -> [String] {
     var set = Set<String>()
     _ = array.reduce(into: []) { tmp, element in
       guard !set.contains(element.translateLanguage) else { return }
       set.insert(element.translateLanguage)
       tmp.append(element.translateLanguage)
     }
     return Array(set)
   }
  
  init() {
    self.model = ListViewModel()
    self.viewModel = TranslateViewModel()
    UITableView.appearance().backgroundColor = .systemGray6
    UITableView.appearance().showsVerticalScrollIndicator = false
    UITableView.appearance().tableFooterView = UIView()
  }
  
  var body: some View {
    
    ZStack(alignment: .bottomTrailing) {
      VStack {
        SearchBar(text: $searchText)
        VStack(alignment: .center, spacing: 10) {
          Spacer()
          HStack {
            Button(action: {self.viewModel.showSourceLanguageSelectionView = true}) {
              if sourceLanguageSelection == "" {
                Text("All Languages")
              } else {
                Text(sourceLanguageSelection)
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
                        self.sourceLanguageSelection = language.name
                        self.viewModel.showSourceLanguageSelectionView = false
                      }) {
                         Text(language.name)
                       }
                    }
                  }
                  Section(header: Text("All Languages")) {
                    Button(action: {
                      self.sourceLanguageSelection = ""
                      self.viewModel.showSourceLanguageSelectionView = false
                    }) {
                      Text("All Languages")
                    }
                    ForEach(self.sourceDuplicateEraser(array: self.cards), id: \.self) { language in
                      Button(action: {
                        self.sourceLanguageSelection = language
                        self.viewModel.showSourceLanguageSelectionView = false
                      }) {
                        Text(language)
                      }
                    }
                  }
                }.listStyle(GroupedListStyle())
              }
            }
            .accentColor(Color(.label))
            .padding(.horizontal)
            .background(Color("SubColor"))
            .cornerRadius(10)
            Spacer()
            Button(action: {self.viewModel.showTargetLanguageSelectionView = true}) {
              if self.targetLanguageSelection == "" {
                Text("All Languages")
              } else {
                Text(self.targetLanguageSelection)
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
                           self.targetLanguageSelection = language.name
                           self.viewModel.showTargetLanguageSelectionView = false
                         }) {
                            Text(language.name)
                          }
                       }
                     }
                     Section(header: Text("All Languages")) {
                       Button(action: {
                         self.targetLanguageSelection = ""
                         self.viewModel.showTargetLanguageSelectionView = false
                       }) {
                         Text("All Languages")
                       }
                      ForEach(self.targetDuplicateEraser(array: self.cards), id: \.self) { card in
                         Button(action: {
                          self.targetLanguageSelection = card
                           self.viewModel.showTargetLanguageSelectionView = false
                         }) {
                          Text(card)
                         }
                       }
                     }
                   }.listStyle(GroupedListStyle())
                 }
            }
            .accentColor(Color(.label))
            .padding(.horizontal)
            .background(Color("SecondSubColor"))
            .cornerRadius(10)
          }
          .frame(width: UIScreen.main.bounds.width * 0.8)
          List {
            ForEach(
              cards.filter { self.sourceLanguageSelection.isEmpty ? true : $0.sourceLanguage == self.sourceLanguageSelection }
                    .filter { self.targetLanguageSelection.isEmpty ? true : $0.translateLanguage == self.targetLanguageSelection }
                    .filter { self.searchText.isEmpty ? true : $0.sourceText.lowercased().contains(self.searchText) || $0.translateText.lowercased().contains(self.searchText)
                
            }, id: \.self) { card in
//              Group {
//                if (self.isEditMode == .active) {
//                  ListView(card: card, width: UIScreen.main.bounds.width * 0.87)
//                  .background(Color(.systemBackground))
//                  .listRowInsets(EdgeInsets())
//                  .listRowBackground(Color(.systemGray6))
//                  .cornerRadius(8)
//                  .padding()
//                } else  {
                  ListView(card: card, width: UIScreen.main.bounds.width * 0.87)
                    .background(Color(.systemBackground))
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding()
//                }
//              }
            }
            .onDelete { indeces in
              self.cards.delete(at: indeces, from: self.viewContext)
            }
            
          }

          .background(Color.yellow)
          .frame(width: UIScreen.main.bounds.width * 0.95)
          .background(Color(UIColor.systemGray6))
          .cornerRadius(8)
        }
        .background(Color(UIColor.systemGray6))
        .cornerRadius(8)
      }
      NavigationLink(destination:
      AddNewCardView()
      ) {
        ZStack {
          Circle()
          .frame(width: 55, height: 55)
            .foregroundColor(.white)
          Image(systemName: "plus.circle.fill")
          .resizable()
          .frame(width: 55, height: 55)
          .foregroundColor(Color("SubColor"))
          .padding()
        }
      }
    }
    .onTapGesture {
      UIApplication.shared.closeKeyboard()
    }
    .onAppear { UITableView.appearance().separatorStyle = .none }
    .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
    .navigationBarTitle("Words List", displayMode: .inline)
    .navigationBarItems(trailing: EditButton())
//    .environment(\.editMode, self.$isEditMode)
  }
}



struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
