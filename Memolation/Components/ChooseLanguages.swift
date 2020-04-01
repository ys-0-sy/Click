//
//  SwiftUIView.swift
//  Memolation
//
//  Created by saito on 2020/04/02.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct ChooseLanguagesView: View {  
  var body: some View {
    ChooseLanguages()
  }
}

struct ChooseLanguages: View {
  var body: some View {
    NavigationView {
      VStack {
        NavigationLink(destination: TranslateView()) {
          Image(systemName: "xmark")
            .frame(width: 10, height: 10)
        }

      List{
        ForEach(TranslationManager.shared.supportedLanguages, id: \.self) { language in
            NavigationLink(destination: TranslateView()) {
              Text(language.name!)
            }
          }
        }
          }
        
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .navigationBarHidden(true)
  }
}

struct ChooseLanguages_Previews: PreviewProvider {
    static var previews: some View {
         ChooseLanguagesView()
    }
}
