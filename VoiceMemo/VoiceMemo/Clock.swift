//
//  Clock.swift
//  VoiceMemo
//
//  Created by John Hatvani on 16/9/21.
//

import Foundation

/// Concrete class implementing Clockable
public class Clock: Clockable {
    public var now: Date = {
        return Date()
    }()
}
