//
//  NavTabView.swift
//  Memolation
//
//  Created by saito on 2020/03/27.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import Combine

struct NavTabView: View {
  var body: some View {
    NavTab()
  }
}

struct NavTab: View {
  @ObservedObject var navViewRouter = NavViewRouter()

  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()
        if self.navViewRouter.currentView == "translation" {
          TranslateView()
            .offset(y: 7)
        } else if self.navViewRouter.currentView == "cards" {
          Text("Cards")
        } else if self.navViewRouter.currentView == "lists" {
          Text("Lists")
        } else if self.navViewRouter.currentView == "settings" {
          Text("Settings")
        }
        Spacer()
        HStack {
          NavigatinButtonView(width: geometry.size.width/6, image: "translation", text: "Translation")
            .offset(y: geometry.size.height >= 768 ? -6 : 0)
            .foregroundColor(self.navViewRouter.currentView == "translation" ? .purple : .gray)
            .onTapGesture {
              print(geometry.size.height)
              self.navViewRouter.currentView = "translation"
          }
          NavigatinButtonView(width: geometry.size.width/5, image: "cards", text: "Cards")
            .offset(y: geometry.size.height >= 768 ? -6 : 0)
            .foregroundColor(self.navViewRouter.currentView == "cards" ? .purple : .gray)
            .onTapGesture {
              self.navViewRouter.currentView = "cards"
            }
          NavigatinButtonView(width: geometry.size.width/5, image: "list", text: "List")
            .offset(y: geometry.size.height >= 768 ? -6 : 0)
            .foregroundColor(self.navViewRouter.currentView == "lists" ? .purple : .gray)
            .onTapGesture {
              self.navViewRouter.currentView = "lists"
            }
          NavigatinButtonView(width: geometry.size.width/5, image: "settings", text: "Settings")
            .offset(y: geometry.size.height >= 768 ? -6 : 0)
            .foregroundColor(self.navViewRouter.currentView == "settings" ? Color("SecondBaseColor") : .gray)
            .onTapGesture {
                self.navViewRouter.currentView = "settings"
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height/10)
        .background(Color.white.shadow(radius: 2))
      }
    }.edgesIgnoringSafeArea(.bottom)
  }
}

struct NavTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavTabView()
    }
}
