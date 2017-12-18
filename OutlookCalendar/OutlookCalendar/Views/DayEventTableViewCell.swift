//
//  DayEventTableViewCell.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/12/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

class DayEventTableViewCell: UITableViewCell {
    // label for event Name
    @IBOutlet weak var eventNameLabel : UILabel?
    // label for event start time
    @IBOutlet weak var eventStartTimeLabel : UILabel?
    // label for event duration
    @IBOutlet weak var eventDurationLabel : UILabel?
    func populateWitEvent(event : EventModel?){
        // Empty all text as cell being reused
        eventDurationLabel?.text = ""
        eventStartTimeLabel?.text = ""
        eventNameLabel?.text = ""
        
        // if event is ther populate with event
        if let eventModel = event{
            eventNameLabel?.text = eventModel.eventName
            if let startTime = eventModel.eventStartTime,let endTime = eventModel.eventEndTime{
                eventStartTimeLabel?.text = "\(startTime.hour)"
                // get the duration in hours and mins and show
                eventDurationLabel?.text = Utils.durationStringFromTimeInterval(endTime.timeIntervalSince(startTime))
            }
        }
    }
}
