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
                                                   ascending: true)], animation: .default) var card: FetchedResults<Card>
  @Environment(\.managedObjectContext) var viewContext
  @State private var cardNum = 0
  @State var isClicked = false
    var body: some View {
      
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
          .padding()
          .frame(width: UIScreen.main.bounds.width * 0.75)
          HStack {
            VStack {
              Spacer()
              Text("Write")
              .padding()
            }
            .frame(width: 130, height: 250)
              .background(
                RoundedRectangle(cornerRadius: 25)
                .stroke()
                  .foregroundColor(Color(UIColor.systemGray))
              )
            Spacer()
            VStack {
              Spacer()
              Text("Flash")
              .padding()
            }
              .frame(width: 130, height: 250)
              .background(
                RoundedRectangle(cornerRadius: 25)
                .stroke()
                  .foregroundColor(Color(UIColor.systemGray))
              )
            
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
        }
        .frame(width: UIScreen.main.bounds.width * 0.95)
        .background(Color(.systemGray6))
        .cornerRadius(8)
      }
//      ZStack {
//        ForEach(card) { card in
//          ClickCard(card: card)
//          .animation(.easeInOut)
//        }
//      }
//      .padding()

      .navigationBarTitle("Click")
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
