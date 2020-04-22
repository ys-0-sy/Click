//
//  ContentView.swift
//  Memolation
//
//  Created by saito on 2020/03/26.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
struct ContentView: View {

  var body: some View {
    TabView {
      TranslateView(viewModel: .init(apiService: APIService()))
        .tabItem {
          Image("translation")
          Text("Translation")
        }
      Text("Cards")
        .tabItem {
          Image("cards")
          Text("Cards")
      }
      Text("Lists")
        .tabItem {
          Image("list")
          Text("Lists")
      }
      Text("Settings")
        .tabItem {
          Image("settings")
          Text("Settings")
      }
    }.accentColor(Color("SecondBaseColor"))
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
