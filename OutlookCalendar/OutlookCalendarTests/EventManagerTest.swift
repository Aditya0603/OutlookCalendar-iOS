//
//  EventManagerTest.swift
//  OutlookCalendarTests
//
//  Created by Aditya Sinha on 12/17/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import XCTest

class EventManagerTest: XCTestCase {
    var eventManager = EventManager()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*Method to test the store ad retrieve of events*/
    func testCheckStoreEvents(){
        var dateComponents = DateComponents()
        dateComponents.year = 1900
        dateComponents.month = 12
        dateComponents.day = 17
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        if let date = date{// store events for an old date and fetch and check if the event is same
            let uniquedateStr = DayManager().getUniqueDateStringForDate(date)
            let eventModel = EventModel(dictionary:[kEventName:"Lunch At Outside",kUniqueDateString:uniquedateStr,kEventStartTime:date,kEventEndTime : Date().addingTimeInterval(3660)])
            eventManager.storeEvents(eventModel: eventModel, forUniqueDate: uniquedateStr)
            // now fetch for the same date and check
            if let eventArr = eventManager.getEventsForUniqueDateString(uniquedateStr){
                // should have atleast one event named Lunch at outside
                var count = 0
                for event in eventArr{
                    if event.eventName == "Lunch At Outside"{
                        count = 1
                    }
                }
                XCTAssertEqual(count, 1)
            }
        }
    }
    
    //TODO: still other negative test scenarios left
}
