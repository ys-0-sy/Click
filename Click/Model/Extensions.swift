//
//  Extensions.swift
//  Cl!ck
//
//  Created by saito on 2020/05/12.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import SwiftUI
public extension Collection {
    subscript(safe index: Index) -> Element? {
        startIndex <= index && index < endIndex ? self[index] : nil
    }
}

extension Encodable {

    var json: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}

extension Decodable {

    static func decode(json data: Data?) -> Self? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
}

extension UserDefaults {

    func set(_ value: Codable?, forKey key: String) {
        guard let json: Any = value?.json else { return } // 2020.02.23 追記参照
        self.set(json, forKey: key)
        synchronize()
    }

    func codable<T: Codable>(forKey key: String) -> T? {
        let data = self.data(forKey: key)
        let object = T.decode(json: data)
        return object
    }
}

extension UIApplication {
    func closeKeyboard() {
      sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
