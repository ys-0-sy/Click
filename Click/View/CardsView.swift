//
//  CardsView.swift
//  Cl!ck
//
//  Created by saito on 2020/05/01.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct CardsView: View {
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.id,
                                                   ascending: true)], animation: .default) var cards: FetchedResults<Card>
  @Environment(\.managedObjectContext) var viewContext
  @State private var cardNum = 0
  @State var isClicked = false
    var body: some View {
      ScrollView(showsIndicators: false ){
      VStack {
        VStack{
          HStack {
            Spacer()
            Text("Total: \(cardNum) Cards")
            Spacer()
            Text("notClicked")
            Toggle("", isOn: $isClicked)
             .labelsHidden()
          }
          .frame(width: UIScreen.main.bounds.width * 0.85)
          .padding(.vertical)
          HStack{
            Text("English")
              .padding(.horizontal)
              .background(
                Capsule()
                .foregroundColor(Color("SubColor"))
            )
            Spacer()
            Image(systemName: "arrow.right")
            Spacer()
            Text("Japanese")
              .padding(.horizontal)
            .background(
            Capsule()
              .foregroundColor(Color("SecondSubColor")))
          }
          .padding(.horizontal)
          .frame(width: UIScreen.main.bounds.width * 0.75)
          HStack {
            NavigationLink(destination: EmptyView()) {
              VStack {
                Image("Write")
                  .resizable()
                  .scaledToFit()
                  .padding()
                Text("Write")
                .padding()
              }
              .frame(width: UIScreen.main.bounds.width * 0.75 / 2.2)
                .background(
                  RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(UIColor.systemBackground))
                  .cornerRadius(25)
                  .shadow(radius: 4, x: 2, y: 2)
                )
            }
            .accentColor(Color(.label))
            Spacer()
            NavigationLink(destination: FlashCardView()) {
              VStack {
                Image("Flash")
                  .resizable()
                  .scaledToFit()
                  .padding()
                Text("Flash")
                  .padding(.vertical)
              }
              .frame(width: UIScreen.main.bounds.width * 0.75 / 2.2)
                .background(
                  RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .cornerRadius(25)
                    .shadow(radius: 4, x: 2, y: 2)
                )
            }
            .accentColor(Color(.label))
            
          }
        .frame(width: UIScreen.main.bounds.width * 0.75)
          .padding(.vertical)
        }
        .frame(width: UIScreen.main.bounds.width * 0.95)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.bottom)

        VStack(alignment: .leading) {
          Text("Cards")
            .font(.title)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .padding(.top)
          ForEach(cards, id: \.self) { card in
              ListView(card: card, width: UIScreen.main.bounds.width * 0.87)
                .background(Color(.systemBackground))
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color(.systemGray6))
                .cornerRadius(8)
                .padding()
          }
          
        }
        .frame(width: UIScreen.main.bounds.width * 0.95)
        .background(Color(.systemGray6))
        .cornerRadius(8)
      }
      }
      .navigationBarTitle("Click")
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
