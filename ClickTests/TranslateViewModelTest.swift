//
//  Tran slateViewModelTest.swift
//  Cl!ckTests
//
//  Created by saito on 2020/05/03.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import XCTest
@testable import Cl_ck

class TranslateViewModelTest: XCTestCase {
  var translateViewModel: TranslateViewModel!
  
  override func setUp() {
    super.setUp()
    translateViewModel = TranslateViewModel()
  }
  
  func testSwitchLanguage() {
    translateViewModel.sourceLanguageSelection = TranslationLanguage(language: "English", name: "en")
    translateViewModel.targetLanguageSelection = TranslationLanguage(language: "Japanese", name: "ja")
    translateViewModel.apply(inputs: .tappedLanguageSwitcher)
    XCTAssert(translateViewModel.sourceLanguageSelection == TranslationLanguage(language: "Japanese", name: "ja"))
    XCTAssert(translateViewModel.targetLanguageSelection == TranslationLanguage(language: "English", name: "en"))
  }
}
