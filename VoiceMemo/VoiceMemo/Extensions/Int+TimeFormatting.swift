//
//  Int_toMinutes.swift
//  VoiceMemo
//
//  Created by John Hatvani on 15/9/21.
//

import Foundation

fileprivate var formatter: DateComponentsFormatter = {
   let f = DateComponentsFormatter()
    f.unitsStyle = .positional
    f.zeroFormattingBehavior = .pad
    return f
}()

extension TimeInterval {
    
    func formattedTime(withUnits units: NSCalendar.Unit = [.minute, .second]) -> String {
        let f = formatter;
        f.allowedUnits = units
        return f.string(from: self) ?? "--/--"
    }
}

extension Int {
    var day: (Int, Calendar.Component) {
        return (self, .day)
    }
}
