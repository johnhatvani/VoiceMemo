//
//  Recording+CoreDataClass.swift
//  VoiceMemo
//
//  Created by John Hatvani on 19/9/21.
//
//

import Foundation
import CoreData

@objc(Recording)
public class Recording: NSManagedObject {

    
    @nonobjc public class func createFetchRequest(withSortDescriptors sort: [NSSortDescriptor]? = nil) -> NSFetchRequest<Recording> {
        let request =  NSFetchRequest<Recording>(entityName: "Recording")
        if (sort != nil) {
            request.sortDescriptors = sort
        }
        
        return request
    }
}
