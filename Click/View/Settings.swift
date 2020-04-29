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
      NavigationView {
        List {
          Text("Version: \(SettingsView.self.shortVersion ?? "") (\(SettingsView.self.version ?? ""))")
        }
      }
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
