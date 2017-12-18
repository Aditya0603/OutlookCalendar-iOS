//
//  AppDelegate.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/6/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        
        
        // A demo event being stored for today to show something in events table
        // Could not implement a  add event VC hence this :P
        let uniquedateStr = DayManager().getUniqueDateStringForDate()
        let eventModel = EventModel(dictionary:[kEventName:"Lunch At Outside",kUniqueDateString:uniquedateStr,kEventStartTime:Date(),kEventEndTime : Date().addingTimeInterval(3660)])
        EventManager().storeEvents(eventModel: eventModel, forUniqueDate: uniquedateStr)
        
        let dateAfterAnHour = Date().addingTimeInterval(3600)
        let eventModel2 = EventModel(dictionary:[kEventName:"Meeting At Office",kUniqueDateString:uniquedateStr,kEventStartTime:dateAfterAnHour,kEventEndTime : dateAfterAnHour.addingTimeInterval(3720)])
        EventManager().storeEvents(eventModel: eventModel2, forUniqueDate: uniquedateStr)
        // Just to print the data that its coming and parsed :P
        // Not being used as of now
        YahooWeatherRequestHandler().getYahooWeatherForecastForLocation(city: "Ranchi", country: "IN") { (forecast, err) in}
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}

