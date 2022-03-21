//
//  Image+CoreDataProperties.swift
//  FlickrAssignment
//
//  Created by Mateus Goncalves De Ouro on 20/03/2022.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var farmValue: Int64
    @NSManaged public var server: String?
    @NSManaged public var secretValue: String?
    @NSManaged public var id: String?
    @NSManaged public var url: String?

}

extension Image : Identifiable {

}
