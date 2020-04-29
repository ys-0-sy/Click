//
//  Cards+CoreDataProperties.swift
//  Cl!ck
//
//  Created by saito on 2020/04/29.
//  Copyright © 2020 ys-0-sy. All rights reserved.
//
//

import Foundation
import CoreData


extension Cards {

    @NSManaged public var id: UUID
    @NSManaged public var sourceLanguage: String
    @NSManaged public var sourceText: String
    @NSManaged public var translateLanguage: String
    @NSManaged public var translateText: String
    @NSManaged public var index: String

}

extension Cards: Identifiable {
  static func getCardsFetchRequiest() -> NSFetchRequest<Cards> {
    let request = Cards.fetchRequest() as! NSFetchRequest<Cards>
    request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
    return request
  }
}
