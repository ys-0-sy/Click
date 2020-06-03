//
//  Card.swift
//  Cl!ck
//
//  Created by saito on 2020/05/10.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Card: Identifiable {
  private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  static func create(in managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext,
                     sourceLanguage: TranslationLanguage = TranslationLanguage(language: "ja", name: "Japanese"),
                     sourceText: String = "",
                     targetLanguage: TranslationLanguage = TranslationLanguage(language: "en", name: "English"),
                     translateText: String = ""
                     ) {
    let newCard = self.init(context: managedObjectContext)
    let index = "\(sourceText)+\(translateText)"
    newCard.sourceLanguage = sourceLanguage.name
    newCard.sourceText = sourceText
    newCard.translateLanguage = targetLanguage.name
    newCard.translateText = translateText
    newCard.index = index
    newCard.id = UUID().uuidString
    newCard.timestamp = Date()
    newCard.isRemembered = false
    
    do {
      managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      try managedObjectContext.save()
    } catch {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
  
  static func fetchCards() -> [Card] {
      let context = persistentContainer.viewContext
      let cardsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")

      do {
          let fetchedCards = try context.fetch(cardsFetch) as! [Card]
          return fetchedCards
      } catch {
        fatalError("Failed to fetch employees: \(error)")
        return []
      }
  }
}


extension Collection where Element == Card, Index == Int {
  func delete(at indicies: IndexSet, from managedObjectContext: NSManagedObjectContext) {
    indicies.forEach { managedObjectContext.delete(self[$0]) }
    
    do {
      try managedObjectContext.save()
    } catch {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
}
