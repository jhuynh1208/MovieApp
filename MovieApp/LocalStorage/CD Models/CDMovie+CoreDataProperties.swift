//
//  CDMovie+CoreDataProperties.swift
//  MovieApp
//
//  Created by Thiện Huỳnh on 3/6/25.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?

}

extension CDMovie : Identifiable {

}
