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
  @Published var detectionLanguage: TranslationLanguage? = nil
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
        onTappedSubject.send()
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
  private let onTappedSubject = PassthroughSubject<Void, Never>()
  private let onCheckLanguageSubject = PassthroughSubject<String, Never>()
  private let errorSubject = PassthroughSubject<APIServiceError, Never>()
  private var cancellables: [AnyCancellable] = []


  private func bind() {
      let tappedResponseSubscriber = onTappedSubject
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
    
      let responseSubscriber = onCheckLanguageSubject
        .flatMap { [apiService] (query) in
          apiService.request(with: DetectionLanguageRequest(query: query))
                .catch { [weak self] error -> Empty<DetectionLanguageResponse, Never> in
                    self?.errorSubject.send(error)
                    print(error)
                    return .init()
                }
        }
        .map{ $0.data.detections}
        .sink(receiveValue: { [weak self] (detections) in
          guard let self = self else { return }
          self.detectionLanguage = self.surpportedLanguages.filter({ $0.language == detections[0].language }).first
          self.isLoading = false
        })

      let errorSubscriber = errorSubject
          .sink(receiveValue: { [weak self] (error) in
              guard let self = self else { return }
              self.isShowError = true
              self.isLoading = false
          })

      cancellables += [
          tappedResponseSubscriber,
          responseSubscriber,
          errorSubscriber
      ]
  }
  
  
  private func convertInput(languages: [TranslationLanguage]) -> [TranslationLanguage] {
    return languages.compactMap { (language) -> TranslationLanguage? in
              return language
      }
  }

}
