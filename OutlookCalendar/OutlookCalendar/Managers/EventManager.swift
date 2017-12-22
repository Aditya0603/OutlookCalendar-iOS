//
//  EventManager.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/12/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

func synced(_ lock: Any, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
class EventManager {
    /*
     Method to store event Models for a date
     */
    func storeEvents(eventModel : EventModel, forUniqueDate uniqueDateString : String){
        // Get documents directory path to store our events modal
        
        // Handling thread safe for file write operation
        synced(self, closure: {
            if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
                // Append your file name to the directory path
                // The file name here is the unique DateString
                let path = (docs as NSString).appendingPathComponent(uniqueDateString)
                // We need to check if a file for the uniqueDate exists or not
                // If yes get all values and append the new one , if not then add the nerw one in new file
                var eventModelsArr = [EventModel]()
                if let eventModelsOldArr = self.getEventsForUniqueDateString(uniqueDateString){
                    eventModelsArr.append(contentsOf: eventModelsOldArr)
                    eventModelsArr.append(eventModel)
                }
                else{
                    eventModelsArr = [EventModel]()
                    eventModelsArr.append(eventModel)
                }
                // Archive your object to date file at that path
                NSKeyedArchiver.archiveRootObject(eventModelsArr, toFile: path)
            }
        })
    }
    
    /*
     Method to retrieve event Models for a date
     */
    func getEventsForUniqueDateString(_ uniqueDateString : String) -> [EventModel]?{
        if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            // Append your file name to the directory path
            let path = (docs as NSString).appendingPathComponent(uniqueDateString)
            
            // Unarchive your object from the file
            let eventModels = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [EventModel]
            
            // TODO: sort these events depending on there start date
            return eventModels
        }
        return nil
    }
}
