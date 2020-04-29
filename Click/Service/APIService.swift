//
//  TranslationModel.swift
//  Memolation
//
//  Created by saito on 2020/04/12.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import Combine

protocol RequestType {
  associatedtype Response: Decodable
  var path: String { get }
  var queryItems: [URLQueryItem]? { get }
}


protocol APIServiceType {
  func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: RequestType
}

final class APIService: APIServiceType {
  private let baseURLString: String
  init(baseURLString: String = "https://translation.googleapis.com") {
    self.baseURLString = baseURLString
  }
  
  func request<Request>(with request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request : RequestType {
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
      .map { data, urlResponse in
//         let str: String? = String(data: data, encoding: .utf8)
//         print(str!)
        return data
        
    }
      .mapError { _ in APIServiceError.responseError }
      .decode(type: Request.Response.self, decoder: decorder)
      .mapError(APIServiceError.parseError)
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
