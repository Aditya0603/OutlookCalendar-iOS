//
//  DayManager.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/10/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

class DayManager {
    // date formatter to convert dates to string
    let dateFormatter = DateFormatter()
    
    /*
     Method to get all the DateModels for our calendar
     */
    func getDateModelsForCalendar(_ completion:@escaping ([DateModel]?,Error?)->Void){
        // Do Computation in background thread
        DispatchQueue.global(qos: .userInitiated).async {
            // Event manager which will get us the events for a date
            let eventManager = EventManager()
            
            // Array to store DateModels
            var dateModelArr = [DateModel]()
            // today date to get all other dates depending on today
            let today = Date()
            // get start and end Dates of our calendar for correaponding today
            let calendarIndexForCalendar = self.getCalendarIndexOfStartAndEndForDate(date: today)
            
            // Run a loop for these values and create DateModels for each date
            // and also get events for the date stored
            for i in calendarIndexForCalendar.startDay...calendarIndexForCalendar.endDay{
                // get the date for the calendar as per the index
                if let date = Calendar.current.date(byAdding: .day, value: i, to: today){
                    // Model Object
                    let dateModel = DateModel()
                    dateModel.date = date
                    
                    // This check is for the first date of a month
                    // If day is not first , just show the date
                    // if day is 1 then we need the calendar to show the month name
                    // also if the year of today and the 1st day is not same then calendar should show year as well
                    // So set the date formatter format accordingly
                    if date.day != 1 {
                        self.dateFormatter.dateFormat = "dd"
                    }
                    else{
                        self.dateFormatter.dateFormat = "MMM dd"
                        if date.year != today.year {
                            self.dateFormatter.dateFormat = "MMM dd yyyy"
                        }
                    }
                    // get the small date value and store in model
                    dateModel.smallDateValue = self.dateFormatter.string(from: date)
                    
                    // Similarily the long date value if the year of date and today is not same
                    // add year to the long date Value
                    if date.year != today.year {
                        self.dateFormatter.dateFormat = "EEEE,MMM dd yyyy"
                    }
                    else{
                        self.dateFormatter.dateFormat = "EEEE,MMM dd"
                    }
                    // get the long date value and store in model
                    dateModel.longDateValue = self.dateFormatter.string(from: date)
                    // get month and store
                    dateModel.month = date.month
                    // get Unique string for date and store
                    dateModel.uniqueDateSring = self.getUniqueDateStringForDate(date)
                    // get the events for that date from the event manager and store
                    dateModel.eventModelArr = eventManager.getEventsForUniqueDateString(dateModel.uniqueDateSring!)
                    // This is to mark the today date
                    // as we need to show that in diff colors
                    if i == 0{
                        dateModel.isToday = true
                    }
                    dateModelArr.append(dateModel)
                }
            }
            DispatchQueue.main.async {
                // Call completion on main thread
                completion(dateModelArr,nil)
            }
        }
    }
    
    /*
     Method to get the start date index from today and endIndex from today,
     for the calendar to show the dates for these
     
     This method has hardcoded values , this is from hit and trial method using the microsoft outlook app
     But these start and end indexes could also come from server as to how many days to show
     Prameter:
     date : The date for which the indexes have to be found
     */
    func getCalendarIndexOfStartAndEndForDate(date : Date)->(startDay: Int, endDay: Int){
        // get the weekday for the date so that we can maintain the offset for different weekdays
        let dayOfWeek = date.weekDay
        // go 3 months back and also the weekday Int back to find the sunday of that week 3 months ago
        // as the calendar should start from Sunday
        let startDay = -dayOfWeek - 90
        // go a year ahead and also the weekday Int ahead to find the saturday of that week
        // as the calendar should end on Saturday
        let endDay = 364+(7-dayOfWeek)
        // return a tuple of the same
        return (startDay,endDay)
    }
    
    /*
     Method to get a unique string for a given date
     No two dates will have the same unique String
     */
    func getUniqueDateStringForDate(_ date : Date = Date())-> String{
        self.dateFormatter.dateFormat = "EEEE,MMM dd yyyy"
        return self.dateFormatter.string(from: date)
    }
}
extension Date {
    // get the year from the date object
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    // get the day from the date object
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    // get the month from the date object
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    // get the hour from the date object
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    // get the weekday from the date object, ranges from 1..7
    var weekDay: Int {
        return Calendar.current.component(.weekday, from: self)
    }
}
