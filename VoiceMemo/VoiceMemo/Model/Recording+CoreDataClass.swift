//
//  Recording+CoreDataClass.swift
//  VoiceMemo
//
//  Created by John Hatvani on 19/9/21.
//
//

import Foundation
import CoreData
import AVFoundation

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

extension Recording {
    
    func getAudioURL() -> URL {
        return getDocumentsURL().appendingPathComponent(filename!)
    }
    
    static func create(withContext ctx: NSManagedObjectContext, transcript: String, filename: String, duration: TimeInterval) throws -> Recording {
        let recording = Recording(context: ctx)
        recording.datetime = Date()
        recording.transcript = transcript
        recording.filename = filename
        recording.duration = duration
    
        return recording
    }
}
