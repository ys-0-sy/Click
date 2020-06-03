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
      }
  }
}

extension CardCount {
  private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  static func create(in managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext) {
    let addCard = self.init(context: managedObjectContext)
    addCard.cardNum = addCard.cardNum + 1
    addCard.date = Date()
    do {
      managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      try managedObjectContext.save()
    } catch {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
  
  static func addCount(in managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CardCount")
    fetchRequest.returnsObjectsAsFaults = false
    if let argDate = date {
      let predicate = NSPredicate(format: "self.date BETWEEN {%@ , %@}", argDate as NSDate, NSDate(timeInterval: 24*60*60-1, since: argDate))
      fetchRequest.predicate = predicate
    }

    do {
    let fetchResults = try managedObjectContext.fetch(fetchRequest) as! [CardCount]
    print(fetchResults)
      for fetchResult in fetchResults {
        let managedObject = fetchResult as NSManagedObject
        managedObject.setValue(fetchResult.cardNum + 1, forKey: "cardNum")
          try managedObjectContext.save()
      }
    } catch {
      let nserror = error as NSError
      fatalError("Update Error \(nserror),  \(nserror.userInfo)")
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
