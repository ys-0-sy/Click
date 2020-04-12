//
//  TranslationModel.swift
//  Memolation
//
//  Created by saito on 2020/04/12.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import Combine

struct TranslationLanguage: Decodable, Hashable {
  var code: String
  var name: String
}

struct FetchSupportedLanguageResponse: Decodable {
  var languages: [TranslationLanguage]
}

protocol FetchSupportedLanguageRequestType {
  associatedtype Response: Decodable
  var path: String { get }
  var queryItems: [URLQueryItem]? { get }
}

struct FetchSupportedLanguageRequest: FetchSupportedLanguageRequestType {
typealias Response = FetchSupportedLanguageResponse
  
  var path: String { return "/language/translate/v2" }
  var queryItems: [URLQueryItem]? {
    return [
      .init(name: "key", value: self.loadKeys()),
      .init(name: "target", value: Locale.current.languageCode ?? "en")
    ]
  }
  private func loadKeys() -> String {
    do {
      let settingURL: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "keys", ofType: "plist")!)
      let data = try Data(contentsOf: settingURL)
      let decoder = PropertyListDecoder()
      let keys = try decoder.decode(Keys.self, from: data)
      return keys.googleAPIKey
    } catch {
      print("apiKeyget error")
      print(error)
      return ""
    }
  }
}

enum APIServiceError: Error {
  case invalidURL
  case responseError
  case parseError(Error)
}

protocol APIServiceType {
  func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: FetchSupportedLanguageRequestType
}

final class APIService: APIServiceType {
  private let baseURLString: String
  init(baseURLString: String = "https://translation.googleapis.com") {
    self.baseURLString = baseURLString
  }
  
  func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request : FetchSupportedLanguageRequestType {
    guard let pathURL = URL(string: request.path, relativeTo: URL(string: baseURLString)) else {
      return Fail(error: APIServiceError.invalidURL).eraseToAnyPublisher()
    }
    
    var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
    urlComponents.queryItems = request.queryItems
    var request = URLRequest(url: urlComponents.url!)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let decorder = JSONDecoder()
    decorder.keyDecodingStrategy = .convertFromSnakeCase
    return URLSession.shared.dataTaskPublisher(for: request)
      .map { data, urlResponse in data }
      .mapError { _ in APIServiceError.responseError }
      .decode(type: Request.Response.self, decoder: decorder)
      .mapError(APIServiceError.parseError)
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
