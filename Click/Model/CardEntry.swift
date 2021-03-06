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
import SwiftDate

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
  
  static func fetchAllCards() -> [Card]{
    let context = persistentContainer.viewContext
    let cardsFetch = NSFetchRequest<Card>(entityName: "Card")
    do {
      return try context.fetch(cardsFetch)
    } catch {
      fatalError("Failed to fetch Cards: \(error)")
    }
  }
  
  static func fetchPersons(onlyAfter isClicked: Bool) -> [Card] {
      let predicate = NSPredicate(format: "isClicked == %@", isClicked)
      return fetchCards(with: predicate)
  }
  
  static func fetchCards(with predicate: NSPredicate) -> [Card]{
    let context = persistentContainer.viewContext
    let cardsFetch = NSFetchRequest<Card>(entityName: "Card")
    cardsFetch.predicate = predicate
    do {
      return try context.fetch(cardsFetch)
    } catch {
      fatalError("Failed to fetch Cards: \(error)")
    }
  }
}

extension CardCount {
  private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  static func create(in managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext) {
    let addCard = self.init(context: managedObjectContext)
    addCard.cardNum = 1
    addCard.addDate = Date()
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
    let argDate = Date() - 1.months
    let sinceDate = Date() + 1.months
    let datePredicate = NSPredicate(format: "self.addDate BETWEEN {%@ , %@}", argDate as NSDate, sinceDate as NSDate)
    fetchRequest.predicate = datePredicate
    do {
      let fetchResults = try managedObjectContext.fetch(fetchRequest) as! [CardCount]
      print("Results: \(fetchResults)")
      if fetchResults.count > 0 {
        for fetchResult in fetchResults {
          if let addDate = fetchResult.value(forKey: "addDate") as! Date? {
            if addDate.compare(.isThisMonth) {
              let managedObject = fetchResult as NSManagedObject
              managedObject.setValue(fetchResult.value(forKey: "cardNum") as! Int + 1, forKey: "cardNum")
                try managedObjectContext.save()
            } else {
              create()
            }
          }

        }
      } else {
        create()
      }
    } catch {
      let nserror = error as NSError
      fatalError("Update Error \(nserror),  \(nserror.userInfo)")
    }
  }
  
  static func fetchCounts() -> [CardCount] {
      let context = persistentContainer.viewContext
      let cardsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CardCount")

      do {
          let fetchedCards = try context.fetch(cardsFetch) as! [CardCount]
          return fetchedCards
      } catch {
        fatalError("Failed to fetch employees: \(error)")
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
