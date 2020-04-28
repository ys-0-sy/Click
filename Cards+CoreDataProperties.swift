//
//  Cards+CoreDataProperties.swift
//  Cl!ck
//
//  Created by saito on 2020/04/28.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//
//

import Foundation
import CoreData


extension Cards {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cards> {
        return NSFetchRequest<Cards>(entityName: "Cards")
    }

    @NSManaged public var id: UUID
    @NSManaged public var sourceLanguage: String
    @NSManaged public var sourceText: String
    @NSManaged public var translateLanguage: String
    @NSManaged public var translateText: String

}

extension Cards: Identifiable {
  
}
