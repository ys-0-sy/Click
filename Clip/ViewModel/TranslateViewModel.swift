//
//  TranslateViewModel.swift
//  Memolation
//
//  Created by saito on 2020/04/12.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import Combine
import UIKit

final class TranslateViewModel: ObservableObject {
  // MARK: - Inputs
  
  enum Inputs {
    case fetchLanguages
    case tappedDetectedLanguageSelection(language: TranslationLanguage)
    case tappedSourceLanguageSelection(language: TranslationLanguage?)
  }
  
  // MARK: -  Outputs
  @Published var sourceText: String = ""
  @Published var translatedText: String = ""
  @Published var targetLanguageSelection = TranslationLanguage(language: "ja", name: "Japanese")
  @Published private(set) var surpportedLanguages: [TranslationLanguage] = []
  @Published var inputText: String = ""
  @Published var isShowError = false
  @Published var isLoading = false
  @Published var isShowSheet = false
  @Published var sourceLanguageSelection: TranslationLanguage? = nil
  @Published var showSourceLanguageSelectionView: Bool = false
  @Published var showTargetLanguageSelectionView: Bool = false
  
  init(apiService: APIServiceType) {
    self.apiService = apiService
    bind()
  }
  
  func apply(inputs: Inputs) {
    switch inputs {
    case .fetchLanguages:
      if surpportedLanguages == [] {
        onCommitSubject.send()
      }
    case .tappedDetectedLanguageSelection(let language):
      showTargetLanguageSelectionView = false
      print(language)
      targetLanguageSelection = language
    case .tappedSourceLanguageSelection(let language):
      showSourceLanguageSelectionView = false
      sourceLanguageSelection = language
    }
  }

  //MARK: - Private
  private let apiService: APIServiceType
  private let onCommitSubject = PassthroughSubject<Void, Never>()
  private let responseSubject = PassthroughSubject<FetchSupportedLanguageResponse, Never>()
  private let errorSubject = PassthroughSubject<APIServiceError, Never>()
  private var cancellables: [AnyCancellable] = []


  private func bind() {
      let responseSubscriber = onCommitSubject
          .flatMap { [apiService] (query) in
              apiService.request(with: FetchSupportedLanguageRequest())
                  .catch { [weak self] error -> Empty<FetchSupportedLanguageResponse, Never> in
                      self?.errorSubject.send(error)
                      print(error)
                      return .init()
                  }
          }
          .map{ $0.data.languages }
          .sink(receiveValue: { [weak self] (languages) in
              guard let self = self else { return }
              self.surpportedLanguages = self.convertInput(languages: languages)
              self.isLoading = false
          })

      let loadingStartSubscriber = onCommitSubject
          .map { _ in true }
          .assign(to: \.isLoading, on: self)

      let errorSubscriber = errorSubject
          .sink(receiveValue: { [weak self] (error) in
              guard let self = self else { return }
              self.isShowError = true
              self.isLoading = false
          })

      cancellables += [
          responseSubscriber,
          loadingStartSubscriber,
          errorSubscriber
      ]
  }
  private func convertInput(languages: [TranslationLanguage]) -> [TranslationLanguage] {
    return languages.compactMap { (language) -> TranslationLanguage? in
              return language
      }
  }

}
