//
//  ContentView.swift
//  Memolation
//
//  Created by saito on 2020/03/26.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
struct ContentView: View {
  @State var selection = 0

  var body: some View {
    TabView(selection: $selection) {
      TranslateView()
        .tabItem {
          VStack {
            Image("translation")
            Text("Translation")
          }
        }
        .tag(0)
      Text("Remember")
        .font(.title)
        .tabItem {
          VStack {
            Image("cards")
            Text("Cards")
          }
        }
        .tag(1)

      Text("Words List")
        .font(.title)
        .tabItem {
          VStack {
            Image("list")
            Text("List")
          }
        }
        .tag(2)

      Text("Settings")
        .font(.title)
        .tabItem {
          VStack {
            Image("settings")
            Text("Settings")
          }
        }
        .tag(3)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
