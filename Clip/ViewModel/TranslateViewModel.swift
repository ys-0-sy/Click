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
  // Mark: -Inputs
  
  enum Inputs {
    case onCommit(text: String)
  }
  
  //Mark Outputs
  @Published var sourceText: String = ""
  @Published var translatedText: String = ""
  @Published var targetLanguageSelection = TranslationLanguage(code: "ja", name: "Japanese")
  var surpportedLanguages = [TranslationLanguage]()
  @Published var inputText: String = ""
  @Published var isShowError = false
  @Published var isLoading = false
  @Published var isShowSheet = false
  @Published var repositoryUrl: String = ""

  func apply(inputs: Inputs) {
      switch inputs {
          case .onCommit(let inputText):
              onCommitSubject.send(inputText)
      }
  }

  //Mark Private
  private let apiService: APIServiceType
  private let onCommitSubject = PassthroughSubject<String, Never>()
  private let responseSubject = PassthroughSubject<FetchSupportedLanguageResponse, Never>()
  private let errprSubject = PassthroughSubject<APIServiceError, Never>()
  private var cancellables: [AnyCancellable] = []

  init(apiService: APIServiceType) {
    self.apiService = apiService
    bind()
  }
  private func bind() {
      let responseSubscriber = onCommitSubject
          .flatMap { [apiService] (query) in
              apiService.request(with: FetchSupportedLanguageRequest())
                  .catch { [weak self] error -> Empty<FetchSupportedLanguageResponse, Never> in
                      //self?.errorSubject.send(error)
                      return .init()
                  }
          }
          .map{ $0.languages }
          .sink(receiveValue: { [weak self] (repositories) in
              guard let self = self else { return }
              //self.cardViewInputs = self.convertInput(repositories: repositories)
              self.inputText = ""
              self.isLoading = false
          })

      let loadingStartSubscriber = onCommitSubject
          .map { _ in true }
          .assign(to: \.isLoading, on: self)

//      let errorSubscriber = errorSubject
//          .sink(receiveValue: { [weak self] (error) in
//              guard let self = self else { return }
//              self.isShowError = true
//              self.isLoading = false
//          })

      cancellables += [
          responseSubscriber,
          loadingStartSubscriber,
//          errorSubscriber
      ]
  }
//  private func convertInput(repositories: [Repository]) -> [CardView.Input] {
//      return repositories.compactMap { (repo) -> CardView.Input? in
//          do {
//              guard let url = URL(string: repo.owner.avatarUrl) else {
//                  return nil
//              }
//              let data = try Data(contentsOf: url)
//              guard let image = UIImage(data: data) else { return nil }
//              return CardView.Input(iconImage: image,
//                                    title: repo.name,
//                                    language: repo.language,
//                                    star: repo.stargazersCount,
//                                    description: repo.description,
//                                    url: repo.htmlUrl)
//
//          } catch {
//              return nil
//          }
//      }
//  }

}
