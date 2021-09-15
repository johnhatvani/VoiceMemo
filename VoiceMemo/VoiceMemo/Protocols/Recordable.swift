//
//  Recording.swift
//  VoiceMemo
//
//  Created by John Hatvani on 15/9/21.
//

import UIKit


/// in memory recording store
fileprivate var store: [Recordable] = [
    Recording(datetime: "2020-09-15T10:33:00+0000".ISO8601toDate(), duration: 66, transcript: "", previewWaveform: nil, recording: nil),
    Recording(datetime: "2020-09-14T09:44:00+0000".ISO8601toDate(), duration: 30, transcript: "", previewWaveform: nil, recording: nil),
    Recording(datetime: "2020-08-13T10:11:00+0000".ISO8601toDate(), duration: 72, transcript: "", previewWaveform: nil, recording: nil),
]

/// insert a new recording to the store
func insertRecording(_ recording: Recordable) {
    store.insert(recording, at: 0)
}

/// get a recording at a specified index path
func getRecording(atIndexPath indexpath: IndexPath) -> Recordable? {
    return store[indexpath.row]
}

func getRecordingsLength() -> Int {
    return store.count
}


/// Recordable datasource. Used to store recordings. Currently in memory store
public protocol Recordable {
    
    var datetime: Date { get }
    var duration: TimeInterval { get }
    var transcript: String { get }
    var previewWaveform: UIImage? { get }
    var recording: Any? { get }
}

/// concrete implementation of Recordable
public struct Recording: Recordable {
    
    public var datetime: Date
    public var duration: TimeInterval
    public var transcript: String
    public var previewWaveform: UIImage?
    public var recording: Any?
    
}
