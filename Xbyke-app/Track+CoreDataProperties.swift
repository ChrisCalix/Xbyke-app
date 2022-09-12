//
//  Track+CoreDataProperties.swift
//  
//
//  Created by Christian Calixto on 12/9/22.
//
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track")
    }

    @NSManaged public var time: String?
    @NSManaged public var distance: String?
    @NSManaged public var startaddress: String?
    @NSManaged public var endaddress: String?

}

extension Track: Identifiable {}
