//
//  Recording+CoreDataProperties.swift
//  VoiceMemo
//
//  Created by John Hatvani on 19/9/21.
//
//

import Foundation
import CoreData


extension Recording {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recording> {
        return NSFetchRequest<Recording>(entityName: "Recording")
    }

    @NSManaged public var datetime: Date?
    @NSManaged public var duration: Double
    @NSManaged public var filename: String?
    @NSManaged public var transcript: String?

}

extension Recording : Identifiable {

}
