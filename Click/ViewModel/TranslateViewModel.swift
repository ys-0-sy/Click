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


protocol TranslateModel{
  func tappedSourceLanguageSelection(language: TranslationLanguage?) -> AnyPublisher<String, Never>
  
  func fetchLanguage()
  
  func tappedDetectedLanguageSelection(language: TranslationLanguage) -> AnyPublisher<String, Never>
  
}

final class TranslateViewModel: ObservableObject {
  // MARK: - Inputs
  
  enum Inputs {
    case fetchLanguages
    case tappedDetectedLanguageSelection(language: TranslationLanguage)
    case tappedSourceLanguageSelection(language: TranslationLanguage?)
    case onCommitText(text: String)
    case tappedLanguageSwitcher
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
  @Published var cardsHistory: [CardsHistory] = []

  
  init() {
    self.apiService = APIService()
    bind()
    apply(inputs: .fetchLanguages)

  }
  
  func apply(inputs: Inputs) {
    switch inputs {
    case .fetchLanguages:
      if surpportedLanguages == [] {
        onTappedSubject.send()
      }
    case .tappedLanguageSwitcher:
      switchLanguage()
    case .tappedDetectedLanguageSelection(let language):
      self.showTargetLanguageSelectionView = false
      self.targetLanguageSelection = language
    case .tappedSourceLanguageSelection(let language):
      self.showSourceLanguageSelectionView = false
      self.sourceLanguageSelection = language
    case .onCommitText(let text):
      if text != "" {
        onCheckLanguageSubject.send(text)
        translateLanguageSubject.send(Translate(query: text, sourceLanguage: self.sourceLanguageSelection, targetLanguage: self.targetLanguageSelection))
      }
    }
  }
  

  
  //MARK: - Private
  private let apiService: APIServiceType
  private let onTappedSubject = PassthroughSubject<Void, Never>()
  private let translateLanguageSubject = PassthroughSubject<Translate, Never>()
  private let onCheckLanguageSubject = PassthroughSubject<String, Never>()
  private let errorSubject = PassthroughSubject<APIServiceError, Never>()
  private var cancellables: [AnyCancellable] = []

  
  private func switchLanguage() {
    if sourceLanguageSelection != nil {
      let tmpSelection = self.sourceLanguageSelection!
      self.sourceLanguageSelection = self.targetLanguageSelection
      self.targetLanguageSelection = tmpSelection
    }
  }
  
  private func addHistory(card: CardsHistory) {
    self.cardsHistory.insert(card, at: 0)
    if self.cardsHistory.count > 5 {
      self.cardsHistory.removeLast()
    }
  }
  
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
            if Locale.current.languageCode != nil {
              self.targetLanguageSelection = self.surpportedLanguages.filter({ $0.language == Locale.current.languageCode! }).first!
            }

          })
    let translationResponseSubscriber = translateLanguageSubject
        .flatMap { [apiService] (query) in
          apiService.request(with: TranslationRequest(query: query.query, targetLanguage: query.targetLanguage, sourceLanguage: query.sourceLanguage))
                .catch { [weak self] error -> Empty<TranslationResponse, Never> in
                    self?.errorSubject.send(error)
                    print(error)
                    return .init()
                }
        }
        .map{ $0.data.translations }
        .sink(receiveValue: { [weak self] (languages) in
          guard let self = self else { return }
          self.translatedText = languages[0].translatedText
          var detectedLanguage: TranslationLanguage? = nil
          if languages[0].detectedSourceLanguage != nil {
            detectedLanguage = self.surpportedLanguages.filter({ $0.language == languages[0].detectedSourceLanguage }).first
          }
          
          let index = "\(self.sourceText)+\(languages[0].translatedText)"
          if !CoreDataModel.getCards().contains(where: { card in card.index == index}) {
            self.addnewCard(sourceLanguage: detectedLanguage?.name ?? self.sourceLanguageSelection?.name, index: index)
          }

          if !self.cardsHistory.contains(where: { card in card.index == index}) {
            // なんとかする
            if ((detectedLanguage?.name ?? self.sourceLanguageSelection?.name) != nil) {
              if detectedLanguage?.name != nil {
                let sourceLanguage = detectedLanguage!.name
                let card = CardsHistory(sourceLanguage: sourceLanguage, sourceText: self.sourceText, translateLanguage: self.targetLanguageSelection.name, translateText: languages[0].translatedText, index: index)
                self.addHistory(card: card)
                
              } else {
                let sourceLanguage = self.sourceLanguageSelection!.name
                let card = CardsHistory(sourceLanguage: sourceLanguage, sourceText: self.sourceText, translateLanguage: self.targetLanguageSelection.name, translateText: languages[0].translatedText, index: index)
                self.addHistory(card: card)
              }
            }

          }

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
          if detections[0][0].language != "und" {
            self.detectionLanguage = self.surpportedLanguages.filter({ $0.language == detections[0][0].language }).first
          } else {
            self.detectionLanguage = nil
          }
          self.isLoading = false
        })

      let errorSubscriber = errorSubject
          .sink(receiveValue: { [weak self] (error) in
              guard let self = self else { return }
              self.isShowError = true
              self.isLoading = false
          })

      cancellables += [
        translationResponseSubscriber,
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
  
  private func addnewCard(sourceLanguage: String?, index: String) {
    
    if sourceLanguage != nil && self.sourceText != "" {
      let newCard = CoreDataModel.newCards()
      newCard.sourceLanguage = sourceLanguage!
      newCard.sourceText = self.sourceText
      newCard.translateLanguage = self.targetLanguageSelection.name
      newCard.translateText = self.translatedText
      newCard.index = index
      newCard.id = UUID()
      CoreDataModel.save()
    }
  }


}
