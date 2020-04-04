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
    NavTab()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
