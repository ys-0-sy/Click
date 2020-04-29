//
//  InfoPlistKeysModel.swift
//  Cl!ck
//
//  Created by saito on 2020/04/30.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

public enum InfoPlistKeys: String, Codable, CaseIterable {

    // Bundle Identifier
    case identifier = "CFBundleIdentifier"
    // アプリ名
    case name = "CFBundleName"
    // ローカル・アプリ名
    case displayName = "CFBundleDisplayName"
    // バージョン
    case shortVersion = "CFBundleShortVersionString"
    // Buildバージョン
    case version = "CFBundleVersion"
    case region = "CFBundleDevelopmentRegion"

    // Deep LinkなどのためのURLScheme
    case URLTypes = "CFBundleURLTypes"
    case typeRole = "CFBundleTypeRole"
    // CFBundleURLTypes内で記述されたURLSchemes
    case URLSchemes = "CFBundleURLSchemes"
    // canOpenURL()で有効を返すためのSchemeリスト
    case applicationQueriesSchemes = "LSApplicationQueriesSchemes"
    case ats = "NSAppTransportSecurity"
    case atsAllowsArbitraryLoads = "NSAllowsArbitraryLoads"
    case backgroundModes = "UIBackgroundModes"
    case launchStoryboardName = "UILaunchStoryboardName"
    case mainStoryboardFile = "UIMainStoryboardFile"
    // Application supports iTunes file sharing iTunesファイル共有フラグ
    case fileSharingEnabled = "UIFileSharingEnabled"

    // 画像をフォトライブラリに保存
    case photoLibraryAddUsageDescription = "NSPhotoLibraryAddUsageDescription"
    // フォトライブラリの利用
    case photoLibraryUsageDescription = "NSPhotoLibraryUsageDescription"
    // 音声認識利用
    case speechRecognitionUsageDescription = "NSSpeechRecognitionUsageDescription"
    // 位置情報の利用 (常に許可)
    case locationAlwaysUsageDescription = "NSLocationAlwaysUsageDescription"
    // 位置情報の利用 (使用中のみ許可)
    case locationWhenInUseUsageDescription = "NSLocationWhenInUseUsageDescription"
    // 位置情報の利用（両方)
    case locationAlwaysAndWhenInUseUsageDescription = "NSLocationAlwaysAndWhenInUseUsageDescription"
    // Bluetooth インターフェースの利用
    case bluetoothPeripheralUsageDescription = "NSBluetoothPeripheralUsageDescription"
    // カレンダーの利用
    case calendarsUsageDescription = "NSCalendarsUsageDescription"
    // カメラの利用
    case cameraUsageDescription = "NSCameraUsageDescription"
    // 連絡先の利用
    case contactsUsageDescription = "NSContactsUsageDescription"
    // ヘルスデータの利用
    case healthShareUsageDescription = "NSHealthShareUsageDescription"
    // ヘルスデータの更新
    case healthUpdateUsageDescription = "NSHealthUpdateUsageDescription"
    // HomeKit設定の利用
    case homeKitUsageDescription = "NSHomeKitUsageDescription"
    // マイクの利用
    case microphoneUsageDescription = "NSMicrophoneUsageDescription"
    // リマインダーの利用
    case remindersUsageDescription = "NSRemindersUsageDescription"
    // Siriへユーザーデータ送信
    case siriUsageDescription = "NSSiriUsageDescription"
    // メディアライブラリの利用
    case appleMusicUsageDescription = "NSAppleMusicUsageDescription"
    // 加速度計の利用
    case motionUsageDescription = "NSMotionUsageDescription"
}

public final class InfoPlistUtil {
    public class func getProperty<T>(_ key: String) -> T? {
        if let dic: Dictionary = Bundle.main.infoDictionary {
            return dic[key] as? T
        }
        return nil
    }
    public class func getProperty<T>(_ key: InfoPlistKeys) -> T? {
        return getProperty(key.rawValue)
    }
}
