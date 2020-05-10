//
//  Card+CoreDataProperties.swift
//  Cl!ck
//
//  Created by saito on 2020/05/10.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var index: String?
    @NSManaged public var sourceLanguage: String?
    @NSManaged public var sourceText: String?
    @NSManaged public var translateLanguage: String?
    @NSManaged public var translateText: String?
    @NSManaged public var isRemembered: Bool
    @NSManaged public var timestamp: Date?

}
