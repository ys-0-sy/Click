//
//  InAppPurchaseView.swift
//  Cl!ck
//
//  Created by saito on 2020/06/01.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI
import SwiftyStoreKit

public var inAppPurchaseFlag = false

func purchase (with PRODUCT_ID: String) {
  SwiftyStoreKit.purchaseProduct(PRODUCT_ID) { (result) in
    switch result {
    case .success(_):
      UserDefaults.standard.set(1, forKey: "buy")
      inAppPurchaseFlag = true
      verifyPurchase(with: PRODUCT_ID)
      break
    case .error(error: _):
      print("Purchase failed error")
      break
    }
    
  }
}

func verifyPurchase (with PRODUCT_ID: String) {
  let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: loadKeys())
  SwiftyStoreKit.verifyReceipt(using: appleValidator) { (result) in
    switch result {
    case .success(let receipt):
      let purchaseResult = SwiftyStoreKit.verifySubscription(ofType: .autoRenewable, productId: PRODUCT_ID, inReceipt: receipt)
      switch purchaseResult {
      case .purchased:
        UserDefaults.standard.set(1, forKey: "buy")
        inAppPurchaseFlag = true
      case .notPurchased:
        break
      case .expired:
        UserDefaults.standard.set(nil, forKey: "buy")
        inAppPurchaseFlag = false
      }
    case .error(let error):
      print(error)
    }
  }
}

private func loadKeys() -> String {
  do {
    let settingURL: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "keys", ofType: "plist")!)
    let data = try Data(contentsOf: settingURL)
    let decoder = PropertyListDecoder()
    let keys = try decoder.decode(Keys.self, from: data)
    return keys.purchaseSecretKey
  } catch {
    print("SecretKeyget error")
    print(error)
    return ""
  }
}
