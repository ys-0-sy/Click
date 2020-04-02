//
//  TranslationManager.swift
//  Memolation
//
//  Created by saito on 2020/03/27.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import Combine

struct TranslationLanguage: Hashable {
  var code: String?
  var name: String?
}

struct Keys: Codable {
    var GoogleAPIKey: String
}

class TranslationManager: NSObject{
  static let shared = TranslationManager()
  private var googleAPIKey: String = ""
  @Published var supportedLanguages = [TranslationLanguage]()
  var sourceLanguageCode: String?
  var textToTranslate: String?
  var targetLanguageCode: String?
  
  override init(){
    super.init()

    self.googleAPIKey = loadKeys()
  }
  
  private func loadKeys() -> String {
    do {
      let settingURL: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "keys", ofType: "plist")!)
      let data = try Data(contentsOf: settingURL)
      let decoder = PropertyListDecoder()
      let keys = try decoder.decode(Keys.self, from: data)
      return keys.GoogleAPIKey
    } catch {
      print("api get error")
      print(error)
      return ""
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
  
  func fetchSupportedLanguages(completion: @escaping (_ success: Bool) -> Void ) {
    var urlParams = [String: String]()
    urlParams["key"] = googleAPIKey
    urlParams["target"] = Locale.current.languageCode ?? "en"
    
    makeRequest(usingTranslationAPI: .supportedLanguages, urlParams: urlParams) { (results) in
      guard let results = results else { completion(false); return }
      
      if let data = results["data"] as? [String: Any], let languages = data["languages"] as? [[String: Any]] {
        
        for lang in languages {
          var languageCode: String?
          var languageName: String?
          
          if let code = lang["language"] as? String {
            languageCode = code
          }
          if let name = lang["name"] as? String {
            languageName = name
          }
          
          self.supportedLanguages.append(TranslationLanguage(code: languageCode, name: languageName))
        }
        
        completion(true)
      } else {
        completion(false)
      }
    }
  }
  
  func translate(completion: @escaping (_ translations: String?) -> Void) {
    guard let textToTranslate = textToTranslate, let targetLanguage = targetLanguageCode else { completion(nil); return }
    
    var urlParams = [String: String]()
    urlParams["key"] = googleAPIKey
    urlParams["q"] = textToTranslate
    urlParams["target"] = targetLanguage
    urlParams["format"] = "text"
    
    if let sourceLanguage = sourceLanguageCode {
      urlParams["source"] = sourceLanguage
    }
    
    makeRequest(usingTranslationAPI: .transelate, urlParams: urlParams) { (results) in
      guard let results = results else { completion(nil); return }
      
      if let data = results["data"] as? [String: Any], let translations = data["translations"] as? [[String: Any]] {
        var allTranslations = [String]()
        for translation in translations {
          if let translatedText = translation["translatedText"] as? String {
             allTranslations.append(translatedText)
          }
        }
        
        if allTranslations.count > 0 {
          completion(allTranslations[0])
        } else {
          completion(nil)
        }
       
      } else {
        completion(nil)
      }
    }
  }
}
