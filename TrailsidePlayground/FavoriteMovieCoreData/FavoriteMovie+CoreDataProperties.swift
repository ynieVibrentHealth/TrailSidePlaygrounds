//
//  FavoriteMovie+CoreDataProperties.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: String?
    @NSManaged public var movieDescription: String?
    @NSManaged public var contentInformation: String?
    @NSManaged public var rentHD: String?
    @NSManaged public var rentSD: String?
    @NSManaged public var buyHD: String?
    @NSManaged public var buySD: String?
    @NSManaged public var imageURL: String?

}
