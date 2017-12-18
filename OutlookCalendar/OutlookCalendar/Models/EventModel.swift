//
//  EventModel.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/10/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit
let kUniqueDateString = "uniqueDateString"
let kEventName = "eventName"
let kEventStartTime = "eventStartTime"
let kEventEndTime = "eventEndTime"

class EventModel: NSObject, NSCoding {
    // unique date string for the event
    var uniqueDateSring : String?
    // event name  for the event
    var eventName : String?
    // event start time
    var eventStartTime : Date?
    // event End time
    var eventEndTime : Date?
    /*
     We can add more as well like Contacts and location for the event and so on
     */
    
    /*
     Method to init the object with a dictionary
     */
    init(dictionary : [String :Any]) {
        uniqueDateSring = dictionary[kUniqueDateString] as? String ?? ""
        eventName = dictionary[kEventName] as? String ?? ""
        eventStartTime = dictionary[kEventStartTime] as? Date
        eventEndTime = dictionary[kEventEndTime] as? Date
    }
    
    /*
     Method to encode the object
     */
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.uniqueDateSring, forKey: kUniqueDateString)
        aCoder.encode(self.eventName, forKey: kEventName)
        aCoder.encode(self.eventStartTime, forKey: kEventStartTime)
        aCoder.encode(self.eventEndTime, forKey: kEventEndTime)
    }
    
    /*
     Method to decode the object
     */
    required convenience init?(coder aDecoder: NSCoder) {
        var dictionary = [String :Any]()
        if let uniqueDateSring = aDecoder.decodeObject(forKey: kUniqueDateString) as? String{
            dictionary[kUniqueDateString] = uniqueDateSring
        }
        if let eventName = aDecoder.decodeObject(forKey: kEventName) as? String{
            dictionary[kEventName] = eventName
        }
        if let eventStartTime = aDecoder.decodeObject(forKey: kEventStartTime) as? Date{
            dictionary[kEventStartTime] = eventStartTime
        }
        if let eventEndTime = aDecoder.decodeObject(forKey: kEventEndTime) as? Date{
            dictionary[kEventEndTime] = eventEndTime
        }
        self.init(dictionary: dictionary)
    }
}
