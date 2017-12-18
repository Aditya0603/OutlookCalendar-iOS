//
//  DateModel.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/10/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

class DateModel {
    // this is actually not required in code but using in test cases
    var date : Date?
    
    // Small Date Value string to just shoew the date valie in collection
    var smallDateValue : String?
    // Long Date Value string to  show the date valie in tableView header
    var longDateValue : String?
    // month of the date model
    var month :Int?
    // bool to store if the date is today to show different colors
    var isToday: Bool?
    // unique Date String for the model to store events
    var uniqueDateSring : String?
    // array of events for the date
    var eventModelArr : [EventModel]?
}
