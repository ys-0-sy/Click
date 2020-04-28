//
//  NSPersistentCloudKitContainer+Extensionswift.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//

import CoreData

extension NSPersistentCloudKitContainer {
    
    /// 保存
    func saveContext(context: NSManagedObjectContext? = nil) {
        
        let context = context ?? viewContext
        
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
    
    /// 取り消し
    func rollback(context: NSManagedObjectContext? = nil) {

        let context = context ?? viewContext
        
        // 変更がなければ何もしない
        guard context.hasChanges else {
            return
        }

        context.rollback()
    }
}
