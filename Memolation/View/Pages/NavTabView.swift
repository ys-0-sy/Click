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
          VStack {
            Image("translation")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .padding(8)
              .frame(width: geometry.size.width/5, height: 60)
            Text("Translation")
              .offset(y: -14)
              .font(.footnote)
          }
            .foregroundColor(self.navViewRouter.currentView == "translation" ? .purple : .gray)
            .onTapGesture {
              self.navViewRouter.currentView = "translation"
          }
          VStack {
            Image("cards")
              .resizable()
              .padding(8)
              .aspectRatio(contentMode: .fit)
              .frame(width: geometry.size.width/5, height: 60)
            Text("Cards")
              .font(.footnote)
            .offset(y: -14)
          }.offset(y: -6)
            .foregroundColor(self.navViewRouter.currentView == "cards" ? .purple : .gray)
            .onTapGesture {
              self.navViewRouter.currentView = "cards"
            }
          VStack {
            Image("list")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .padding(8)
              .frame(width: geometry.size.width/5, height: 60)
            Text("List")
              .font(.footnote)
              .offset(y: -14)
          }
            .foregroundColor(self.navViewRouter.currentView == "lists" ? .purple : .gray)
            .onTapGesture {
              self.navViewRouter.currentView = "lists"
            }
          VStack {
            Image("settings")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .padding(8)
              .frame(width: geometry.size.width/5, height: 60)
            Text("Settings")
            .font(.footnote)
            .offset(y: -14)
          }
            .foregroundColor(self.navViewRouter.currentView == "settings" ? Color("SecondColor") : .gray)
            .onTapGesture {
                self.navViewRouter.currentView = "settings"
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height/9)
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
