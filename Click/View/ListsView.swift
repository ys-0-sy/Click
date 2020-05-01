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
  @ObservedObject var model: ListViewModel
  @ObservedObject var common: CommonViewModel
  
  init() {
    self.model = ListViewModel()
    self.common = CommonViewModel()
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      NavigationView {
        List {
          ForEach(self.common.cards, id: \.self) { card in
            ListView(card: card)
          }
          .onDelete(perform: self.common.onDelete)
        }
        .frame(width: UIScreen.main.bounds.width)
        .onAppear(perform: self.common.onAppear)
      }
      .navigationBarHidden(false)
      .navigationBarTitle(Text("List"))
    }
  }

}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
