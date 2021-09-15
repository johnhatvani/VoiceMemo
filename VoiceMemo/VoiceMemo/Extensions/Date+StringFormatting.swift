//
//  Date_formattedString.swift
//  VoiceMemo
//
//  Created by John Hatvani on 16/9/21.
//

import Foundation


fileprivate var formatter: DateFormatter = {
   let f = DateFormatter()
    f.dateFormat = "EEEE, MMM d, yyyy"
    return f
}()

extension Date {

    func recordingListFormat(_ clock: Clockable = Clock()) -> String {
        let cal = Calendar.current
        if (cal.startOfDay(for: clock.now) == cal.startOfDay(for: self)) {
            return "Today"
        }
                
        if (cal.startOfDay(for: (clock.now - 1.day)!) == cal.startOfDay(for: self)) {
            return "Yesterday"
        }
        
        return formatter.string(from: self)
    }
}

public func - (date: Date, tuple: (value: Int, unit: Calendar.Component)) -> Date? {
    return Calendar.current.date(byAdding: tuple.unit, value: (-tuple.value), to: date)
}

public func + (date: Date, tuple: (value: Int, unit: Calendar.Component)) -> Date? {
    return Calendar.current.date(byAdding: tuple.unit, value: tuple.value, to: date)
}
