//
//  TranslationManager.swift
//  Memolation
//
//  Created by saito on 2020/03/27.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation

class TranslationManager: NSObject {
  static let shared = TranslationManager()
  private var googleAPIKey: String = ""
  var sourceLanguageCode: String?
  
  override init(){
    super.init()
    if let keyString =  Bundle.main.object(forInfoDictionaryKey: "GoogleAPIKey") as? String {
      if (KeyManager().getValue(key: keyString) as? String) != nil {
        self.googleAPIKey = KeyManager().getValue(key: keyString) as! String
      } else {
        print("API Key get Error")
      }
    } else {
        print("Dictionaly Key doesn't set")
    }
  }
  
  private func makeRequest(usingTranslationAPI api: TranslationAPI, urlParams: [String: String], completion: @escaping (_ resuslts: [String: Any]?) -> Void) {
    
    if var components = URLComponents(string: api.getURL()) {
      components.queryItems = [URLQueryItem]()
      
      for (key, value) in urlParams {
        components.queryItems?.append(URLQueryItem(name: key, value: value))
      }
      
      if let url = components.url {
        var request = URLRequest(url: url)
        request.httpMethod = api.getHTTPMethod()
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) {(results, response, error) in
          if let error = error {
            print(error)
            completion(nil)
          } else {
            if let response = response as? HTTPURLResponse, let results = results {
              if response.statusCode == 200 || response.statusCode == 201 {
                do {
                  if let resultsDict = try JSONSerialization.jsonObject(with: results, options: .mutableLeaves) as? [String: Any] {
                    completion(resultsDict)
                  }
                } catch {
                  print(error.localizedDescription)
                }
              }
            } else {
              completion(nil)
            }
          }
        }
        task.resume()
      }
    }
  }
  
  func detectLanguage(forText text: String, completion: @escaping(_ language: String?) -> Void) {
    let urlParams = ["key": googleAPIKey, "q": text]
    
    makeRequest(usingTranslationAPI: .detectLanguage, urlParams: urlParams) { (results) in
      guard let results = results else { completion(nil); return }
      
      if let data = results["data"] as? [String: Any], let detections = data["detections"] as? [[[String: Any]]] {
        var detectedLanguages = [String]()
        
        for detection in detections {
          for currentDetection in detection {
            if let language = currentDetection["language"] as? String {
              detectedLanguages.append(language)
            }
          }
        }
        
        if detectedLanguages.count > 0 {
          self.sourceLanguageCode = detectedLanguages[0]
          completion(detectedLanguages[0])
        } else {
          completion(nil)
        }
      } else {
        completion(nil)
      }
    }
  }
}
