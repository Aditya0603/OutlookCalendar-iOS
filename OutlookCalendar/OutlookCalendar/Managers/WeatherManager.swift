//
//  WeatherManager.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/10/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

// Could not finish this but the plan was to have a WeatherManager
// which could handle all different Requests for weather forecast , eg. Yahoo, Forecast.io, Wunderground
// so the weather manager could decide which forecast request handler to call
// but all will parse and create Forecast objects to be returned
class WeatherManager {
    
    var city : String?
    var country: String?
    
    func getForecast(completionHandler:@escaping ([Forecast]?,Error?)->Void) {
        /*
            Code here could take a config value which can be set by developer and could come from server or anywhere
         And depending on the key the WeatherManager could decide which method to call
         
         Something like
         if config == "yahoo"{
         getForecastFromYahoo(completionHandler:completionHandler)
         }
         */
    }
    private func getForecastFromYahoo(completionHandler:@escaping ([Forecast]?,Error?)->Void) {
        /*
         YahooWeatherRequestHandler().getYahooWeatherForecastForLocation(city: "Ranchi", country: "IN") { (forecast, err) in
         }
         */
    }
    private func getForecastFromWunderground(completionHandler:@escaping ([Forecast]?,Error?)->Void) {
        
    }
    private func getForecastFromForecast(completionHandler:@escaping ([Forecast]?,Error?)->Void) {
        
    }
}
