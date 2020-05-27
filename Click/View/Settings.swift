//
//  Settings.swift
//  Memolation
//
//  Created by saito on 2020/04/04.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  static var version: String? = { return InfoPlistUtil.getProperty(.version) }()
  static var shortVersion: String? = { return InfoPlistUtil.getProperty(.shortVersion) }()
    var body: some View {
      List {
        Text("Contact us")
        Button(action: {UIApplication.shared.open(URL(string: "https://twitter.com/ys_0_sy")!) }) {
          Text("Twitter")
        }
        Text("Version: \(SettingsView.self.shortVersion ?? "") (\(SettingsView.self.version ?? ""))")
      }
    .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
