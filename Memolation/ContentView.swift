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
        TabView(selection: $selection){
            TranslateView()
                .tabItem {
                  Image("translate")
                    .padding(.top)
                }
                .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("cards")
                    }
                }
                .tag(1)
            Text("3 View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("add")
                    }
                }
                .tag(2)
            
            Text("4 View")
              .font(.title)
              .tabItem {
                  VStack {
                      Image("list")
                  }
              }
              .tag(3)
          
            Text("5 View")
              .font(.title)
              .tabItem {
                  VStack {
                      Image("settings")
                  }
              }
              .tag(4)
        }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
