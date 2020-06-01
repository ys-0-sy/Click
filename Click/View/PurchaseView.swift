//
//  PurchaseView.swift
//  Cl!ck
//
//  Created by saito on 2020/06/01.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct PurchaseView: View {
  @State private var stateInAppPurchaseFlag = false
  
  var body: some View {
    VStack {
      Text("hello")
      if !self.stateInAppPurchaseFlag {
        Button(action: {
          purchase(with: "com.ys_0_sy.click")
        }) {
          Text("Please Purchase")
        }
      }

    }
      .onAppear {
        verifyPurchase(with: "com.ys_0_sy.click")
        if UserDefaults.standard.object(forKey: "buy") != nil {
          let count = UserDefaults.standard.object(forKey: "buy") as! Int
          if count == 1 {
            inAppPurchaseFlag = true
          }
        } else {
          inAppPurchaseFlag = false
        }
        guard inAppPurchaseFlag else {
          purchase(with: "com.ys_0_sy.click")
          return
        }
        
        print("InAppPurchase is exist. inAppPurchaseFlag: \(inAppPurchaseFlag)")
        
        self.stateInAppPurchaseFlag = inAppPurchaseFlag
    }
  }
}

struct PurchaseView_Previews: PreviewProvider {
  static var previews: some View {
    PurchaseView()
  }
}
