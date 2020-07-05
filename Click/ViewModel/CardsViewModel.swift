//
//  CardsViewModel.swift
//  Cl!ck
//
//  Created by saito on 2020/07/04.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class CardsViewModel: ObservableObject  {
  // MARK: - Inputs
  
  
  
  // MARK: - OutPuts
  @Published var cardNum:Int
  @Published var isClicked = false
  @Published var cards: [Card] = Card.fetchAllCards()
  init() {
    cardNum = 0
  }
  // MARK: - Private

}
