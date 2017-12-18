//
//  EventModelTest.swift
//  OutlookCalendarTests
//
//  Created by Aditya Sinha on 12/17/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import XCTest

class EventModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization(){
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 12
        dateComponents.day = 17
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        if let date = date{
            let uniquedateStr = DayManager().getUniqueDateStringForDate(date)
            let eventModel = EventModel(dictionary:[kEventName:"Lunch At Outside",kUniqueDateString:uniquedateStr,kEventStartTime:Date(),kEventEndTime : Date().addingTimeInterval(3660)])
            XCTAssertEqual(eventModel.uniqueDateSring, "Sunday,Dec 17 2017")
            XCTAssertEqual(eventModel.eventName, "Lunch At Outside")
        }
    }
}
