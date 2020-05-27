//
//  ListsView.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import CoreData

struct ListsView: View {
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.id, ascending: true)], animation: .default) var cards: FetchedResults<Card>
  @Environment(\.managedObjectContext) var viewContext
  @State var isEditMode: EditMode = .inactive
  @ObservedObject var model: ListViewModel
  @State private var searchText : String = ""
  @State private var onEdit = false
  private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  
  init() {
    self.model = ListViewModel()
    UITableView.appearance().backgroundColor = .systemGray6
    UITableView.appearance().showsVerticalScrollIndicator = false
    UITableView.appearance().tableFooterView = UIView()
  }
  
  var body: some View {
    
    ZStack(alignment: .bottomTrailing) {
      VStack {
        SearchBar(text: $searchText)
        VStack(alignment: .center, spacing: 10) {
          HStack {
            Text("English")
            Text("Japanese")
          }
          List {
            ForEach(cards.filter {
              self.searchText.isEmpty ? true : $0.sourceText.lowercased().contains(self.searchText) || $0.translateText.lowercased().contains(self.searchText)

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
