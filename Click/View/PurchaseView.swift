//
//  PurchaseView.swift
//  Cl!ck
//
//  Created by saito on 2020/06/01.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import SwiftyStoreKit
import PartialSheet

struct PurchaseView: View {
  @EnvironmentObject var partialSheetManager : PartialSheetManager
  @Binding var stateInAppPurchaseFlag: Bool
  @State var priceString: String = ""
  @State var productInfo = ""
  
  var body: some View {
    VStack {
      Text("You've reached your free translate\nlimit for this month.")
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
        .lineLimit(nil)
      Text("Subscribe now for unlimited access.")
        .fontWeight(.bold)
      .padding(.bottom)
      Button(action: {
        purchase(with: "com.ys_0_sy.click")
        self.partialSheetManager.closePartialSheet()

      }) {
        HStack {
          Text(productInfo)
          Text("\(priceString)/Month")
        }
        .foregroundColor(Color.white)
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 8)
          .foregroundColor(Color("SubColor"))
        )
      }
      Button(action: {
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
        self.partialSheetManager.closePartialSheet()

      }) {
        Text("Already a subscriber? Restore your purches.")
          .font(.caption)
      }
    .padding()

    }
      .onAppear {
        SwiftyStoreKit.retrieveProductsInfo(["com.ys_0_sy.click"]) { result in
            if let product = result.retrievedProducts.first {
              self.productInfo = product.localizedTitle
              self.priceString = product.localizedPrice!
              print("Product: \(product.localizedDescription), price: \(self.priceString)")
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
              print("Error: \(result.error ?? "" as! Error)")
            }
        }
    }
  }
}

struct PurchaseView_Previews: PreviewProvider {
  static var previews: some View {
    PurchaseView(stateInAppPurchaseFlag: .constant(false))
      .previewLayout(.sizeThatFits)
  }
}
