//
//  VoiceMemoTests.swift
//  VoiceMemoTests
//
//  Created by John Hatvani on 14/9/21.
//

import XCTest
@testable import VoiceMemo

/// concrete implrmentation of Clockable protocol
/// now returns hard coded time to base test off of (15-09-2021 09:30)
class TestClock: VoiceMemo.Clockable {
    var now: Date = Date(timeIntervalSince1970: 1631698200) // 15-09-2021 09:30
}

class VoiceMemoTests: XCTestCase {

    func testISODateStringConversion() throws {
        let now = TestClock().now;
        let compare = "2021-09-15T09:30:00+00:00".ISO8601toDate()
        
        XCTAssert(now == compare)
    }

    func testDateBySubtrackingDay() throws {
        let yesterday = TestClock().now - 1.day
        let compare = Date(timeIntervalSince1970: 1631611800) // 14-09-2021 09:30
        
        XCTAssert(yesterday == compare)
    }
    
    func testDateByAddingDay() throws {
        let tomorrow = TestClock().now + 1.day
        let compare = Date(timeIntervalSince1970: 1631784600) // 16-09-2021 09:30
        
        XCTAssert(tomorrow == compare)
    }
    
    func testFormatterToday() throws {
        let recordDate = "2021-09-15T09:30:00+00:00".ISO8601toDate()
        let output = recordDate.recordingListFormat(TestClock())
        
        XCTAssert(output == "Today")
    }
    
    func testFormatterYesterday() throws {
        let recordDate = "2021-09-14T09:30:00+00:00".ISO8601toDate() // 14-09-2021
        let output = recordDate.recordingListFormat(TestClock())
        
        XCTAssert(output == "Yesterday")
    }
    
    func testFormatterDateFormat() throws {
        let recordDate = "2021-08-30T16:30:00+10:00".ISO8601toDate() // 30-08-2021
        let output = recordDate.recordingListFormat()
        
        XCTAssert(output == "Monday, Aug 30, 2021");
    }
}
