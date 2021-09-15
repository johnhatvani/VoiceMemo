//
//  Clock.swift
//  VoiceMemo
//
//  Created by John Hatvani on 15/9/21.
//

import Foundation

/// Use a Clockable interface to declare global date for getting current date object.
/// Useful for testing date based functions
public protocol Clockable {
    var now: Date { get }
}
