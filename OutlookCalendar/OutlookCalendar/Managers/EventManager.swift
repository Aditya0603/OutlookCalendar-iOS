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
    static var lock = NSLock()
    /*
     Method to store event Models for a date
     */
    func storeEvents(eventModel : EventModel, forUniqueDate uniqueDateString : String){
        // Get documents directory path to store our events modal
        
        // Handling thread safe for file write operation
        // was also trying the above synced method to do the same
//        synced(self, closure: {
        
        //Acquire lock
        EventManager.lock.lock()
            if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
                // Append your file name to the directory path
                // The file name here is the unique DateString
//                sleep(10)
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
        
        // Just for testing the locking beahviour
        // Called this method from two diff threads at same time first from Main thread
        // made the first thread sleep for 20 secs but
        // call from other thread only comes after first thread has woken up and released the lock
        // if (currentQueueName()?.contains("1"))!{
        //     sleep(20)
        //     print("woke up")
        // }
        
        // release the lock
        EventManager.lock.unlock()
//        })
    }
    func currentQueueName() -> String? {
        let name = __dispatch_queue_get_label(nil)
        return String(cString: name, encoding: .utf8)
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
