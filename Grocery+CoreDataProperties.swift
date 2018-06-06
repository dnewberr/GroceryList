//
//  Grocery+CoreDataProperties.swift
//  Grocery List
//
//  Created by Deborah Newberry on 6/5/18.
//  Copyright © 2018 Deborah Newberry. All rights reserved.
//
//

import Foundation
import CoreData


extension Grocery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grocery> {
        return NSFetchRequest<Grocery>(entityName: "Grocery")
    }

    @NSManaged public var item: String?

}
