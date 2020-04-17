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
    case fetchLanguages(Void)
  }
  
  // MARK: -  Outputs
  @Published var sourceText: String = ""
  @Published var translatedText: String = ""
  @Published var targetLanguageSelection = TranslationLanguage(code: "ja", name: "Japanese")
  var surpportedLanguages = [TranslationLanguage]()
  @Published var inputText: String = ""
  @Published var isShowError = false
  @Published var isLoading = false
  @Published var isShowSheet = false
  
  init(apiService: APIServiceType) {
    self.apiService = apiService
    bind()
  }
  
  func apply(inputs: Inputs) {
      switch inputs {
          case .fetchLanguages():
              onCommitSubject.send()
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
                      return .init()
                  }
          }
          .map{ $0.languages }
          .sink(receiveValue: { [weak self] (repositories) in
            print(repositories)
              guard let self = self else { return }
//              self.cardViewInputs = self.convertInput(repositories: repositories)
              self.surpportedLanguages = self.convertInput(repositories: repositories)
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
  private func convertInput(repositories: [TranslationLanguage]) -> [TranslationLanguage] {
    return repositories.compactMap { (repo) -> TranslationLanguage? in
          do {
              print(repo)
              return repo

          } catch {
              return nil
          }
      }
  }

}
