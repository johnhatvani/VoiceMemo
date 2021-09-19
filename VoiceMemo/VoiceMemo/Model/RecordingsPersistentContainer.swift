//
//  RecordingsPersistentContainer.swift
//  VoiceMemo
//
//  Created by John Hatvani on 19/9/21.
//

import Foundation
import CoreData

class RedordingsPersistentContainer: NSPersistentContainer {
    
func saveContext(_ backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
    func getRecordingEntity() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: "Recording", in: viewContext)!
    }
}
