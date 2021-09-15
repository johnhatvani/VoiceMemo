//
//  String_toDate.swift
//  VoiceMemo
//
//  Created by John Hatvani on 15/9/21.
//

import Foundation

fileprivate var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return df
}()


extension String {
    /// Converts an ISO8601 string to Date
    func ISO8601toDate() -> Date {
        return dateFormatter.date(from: self) ?? Date()
    }
}
