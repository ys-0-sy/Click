//
//  CoreDataModel.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NSPersistentCloudKitContainer {
    
    /// viewContextで保存
    func saveContext() {
        saveContext(context: viewContext)
    }

    /// 指定したcontextで保存
    /// マルチスレッド環境でのバックグラウンドコンテキストを使う場合など
    func saveContext(context: NSManagedObjectContext) {
        
        // 変更がなければ何もしない
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        }
        catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}

class CoreDataModel {
    
  private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
  private init() {
  }
    
  static func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
       try context.save()
      } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  static func save() {
      persistentContainer.saveContext()
  }
}



extension CoreDataModel {
    static func newCards() -> Cards {
        let context = persistentContainer.viewContext
        let card = NSEntityDescription.insertNewObject(forEntityName: "Cards", into: context) as! Cards
        return card
    }
  
  static func getCards() -> [Cards] {
      
      let context = persistentContainer.viewContext
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cards")
      
      do {
          let cards = try context.fetch(request) as! [Cards]
          return cards
      }
      catch {
          fatalError()
      }
  }
}
