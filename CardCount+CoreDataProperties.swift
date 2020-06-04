//
//  CardCount+CoreDataProperties.swift
//  Cl!ck
//
//  Created by saito on 2020/06/03.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//
//

import Foundation
import CoreData


extension CardCount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardCount> {
        return NSFetchRequest<CardCount>(entityName: "CardCount")
    }

    @NSManaged public var cardNum: Int64
    @NSManaged public var addDate: Date

}
