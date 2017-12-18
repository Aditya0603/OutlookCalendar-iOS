//
//  DayManagerTest.swift
//  OutlookCalendarTests
//
//  Created by Aditya Sinha on 12/17/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import XCTest

class DayManagerTest: XCTestCase {
    var dayManager = DayManager()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetDateModelsForCalendar(){
        let expectation = self.expectation(description: "GetCalendar")
        var dateModelFetched : [DateModel]?
        dayManager.getDateModelsForCalendar { (dateModel, err) in
            dateModelFetched = dateModel
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 20) { (err) in
            if let dateModelFetched = dateModelFetched{
                // check for first object
                if let firstDate = dateModelFetched[0].date{
                    XCTAssertEqual(firstDate.weekDay, 1)// Weekday should be sunday for 1st object in Calendar
                }
                // check for last object
                if let lastdate = dateModelFetched.last?.date{
                    XCTAssertEqual(lastdate.weekDay, 7)// Weekday should be Saturday for Last object
                }
                // check For today
                let todayIndex = 90+Date().weekDay
                let todayDateModel = dateModelFetched[todayIndex]// this shud be the today object
                let df = DateFormatter()
                df.dateFormat = "EEEE,MMM dd yyyy"
                let actualStr = df.string(from: Date())
                XCTAssertEqual(todayDateModel.uniqueDateSring, actualStr)// compare there unique Strings
                if let isToday = todayDateModel.isToday{
                    XCTAssert(isToday, "This object should be today")
                }
                else{
                    XCTAssert(false, "Did not get istoday")
                }
            }
        }
    }
    
    func testGetCalendarIndexOfStartAndEndForDate(){
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 12
        dateComponents.day = 17
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        if let date = date{// this is for 17th Dec 2017 the indexes should return -91 and 370
            let indexes = dayManager.getCalendarIndexOfStartAndEndForDate(date:date)
            XCTAssertEqual(indexes.startDay, -91)
            XCTAssertEqual(indexes.endDay, 370)
        }
    }
    
    func testGetUniqueDateStringForDate(){
        var dateComponents = DateComponents()
        dateComponents.year = 2017
        dateComponents.month = 12
        dateComponents.day = 17
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        if let date = date{
            let string = dayManager.getUniqueDateStringForDate(date)
            XCTAssertEqual(string, "Sunday,Dec 17 2017")
        }
    }
    
    func testGetUniqueDateStringForToday(){
        let df = DateFormatter()
        df.dateFormat = "EEEE,MMM dd yyyy"
        let actualStr = df.string(from: Date())
        let string = dayManager.getUniqueDateStringForDate()
        XCTAssertEqual(string, actualStr)
    }
    
    // TODO : Implemtent test cases for Date Extensions
    // Could not finish this
}
