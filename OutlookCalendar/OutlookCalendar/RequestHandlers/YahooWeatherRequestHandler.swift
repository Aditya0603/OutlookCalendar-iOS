//
//  YahooWeatherRequestHandler.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/12/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

class YahooWeatherRequestHandler {
    /*
     Method to get yahoo weather forecast
     */
    func getYahooWeatherForecastForLocation(city:String,country:String, completionHandler:@escaping ([Forecast]?,Error?)->Void){
        let urlStr = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(city)%2C%20\(country)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        guard let url = URL(string:urlStr) else {
            // TODO: Create proper error object and return completion
            completionHandler(nil,nil)
            return
        }
        let request = URLRequest(url:url)
        WebServiceBaseManager.default.sendRequest(request: request) { (data, err) in
            guard let data = data else{
                completionHandler(nil,err)
                return
            }
            do{
                // Parse the response and form ForecastObjects to display in events
                // Could not finish this was thinking of holding the forecast for a day in the day model
                // and showing relevant info to the user
                // So lunch at outside could recommend the user to take a umbrella as forecast is cloudy
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                if let json = json,let query = json["query"] as? [String:AnyObject],
                    let results = query["results"] as? [String:AnyObject],
                    let channel = results["channel"] as? [String:AnyObject],
                    let item = channel["item"] as? [String:AnyObject],
                    let forecastArr = item["forecast"] as? [AnyObject]{
                    forecastArr.forEach({
                        if let forecastDict = $0 as? [String:AnyObject]{
                            print(forecastDict)
                        }
                    })
                }
            }
            catch{
                // TODO: Create proper error object and return completion
                completionHandler(nil,nil)
            }
        }
    }
}
