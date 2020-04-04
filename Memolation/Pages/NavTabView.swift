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
  @State var showPopUp = false

  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()
        if self.navViewRouter.currentView == "home" {
          Text("Home")
        } else if self.navViewRouter.currentView == "settings" {
          Text("Settings")
        }
        Spacer()
        ZStack {
          if self.showPopUp {
             PlusMenu()
               .offset(y: -geometry.size.height/6)
           }
          HStack {
            Image("translation")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .padding(8)
              .frame(width: geometry.size.width/3, height: 75)
              .foregroundColor(self.navViewRouter.currentView == "home" ? .black : .gray)
              .onTapGesture {
                self.navViewRouter.currentView = "home"
            }
            ZStack {
          
              Circle()
                .foregroundColor(Color.white)
                .frame(width: 75, height: 75)
              Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: self.showPopUp ? 90: 0))
            }
              .offset(y: -geometry.size.height/10/2)
              .onTapGesture {
                withAnimation {
                  self.showPopUp.toggle()
                }
              }
            Image(systemName: "gear")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .padding(20)
              .frame(width: geometry.size.width/3, height: 75)
              .foregroundColor(self.navViewRouter.currentView == "settings" ? .black : .gray)
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
}

struct PlusMenu: View {
  var body: some View {
    HStack(spacing: 50) {
      ZStack {
        Circle()
          .foregroundColor(Color.blue)
          .frame(width: 70, height: 70)
        Image(systemName: "camera")
        .resizable()
          .aspectRatio(contentMode: .fit)
        .padding(20)
          .frame(width: 70, height: 70)
          .foregroundColor(.white)
      }
      ZStack {
        Circle()
          .foregroundColor(Color.blue)
          .frame(width: 70, height: 70)
        Image(systemName: "photo")
        .resizable()
          .aspectRatio(contentMode: .fit)
        .padding(20)
          .frame(width: 70, height: 70)
          .foregroundColor(.white)
      }
    }
    .transition(.scale)
  }
}

struct NavTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavTabView()
    }
}
