//
//  Trip+CoreDataProperties.swift
//  PA6
//
//  Created by user180005 on 11/17/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var destinationName: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var startDate: Date?
    @NSManaged public var imageName: String?

}

extension Trip : Identifiable {

}
