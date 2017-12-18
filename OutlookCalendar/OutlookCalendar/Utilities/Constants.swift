//
//  Constants.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/10/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

class Constants {
    // Segue to show the events Table right at view did load of CalendarVC
    static let eventsTableSegue = "eventsTableSegue"
    
    // Enum to store colection Cell Identifiers
    enum CollectionCell :String {
        case DayCell = "DayCell"
    }
    
    // Enum to store Table Cell Identifiers
    enum TableCell :String {
        case DateCell = "DateTableCell"
        case EmptyCell = "EmptyTableCell"
    }
    
    // Enum to store colection Cell Identifiers
    static let eventsTableHeaderFont = UIFont.systemFont(ofSize: 20)
    
    //Should Have Used a different file for Colors but just for the timeBeing
    
    //Colour for the table header view and collection cells, even odd
    static let veryLightGrayColor = UIColor(red:0.95,green:0.95,blue:0.95,alpha:1.0)
    
    //Colour for the today header view in Events tableview
    static let veryLightBLUEColor = UIColor(red:(237.0/255.0),green:(241.0/255.0),blue:(250.0/255.0),alpha:1.0)
}

class Utils {
    /*
     Method to display the provided time interval in hours and mins
     
     Param : timeInterval - the time interval to be converted to hours and mins
     */
    static func durationStringFromTimeInterval(_ timeInterval: TimeInterval) -> String{
        var textToShow = ""
        let hours : Int = Int(timeInterval/3600)
        textToShow.append("\(hours) h")
        let mins : Int = Int(timeInterval/60) % 60
        textToShow.append(" \(mins) m")
        return textToShow
    }
}

extension UIView{
    /*
     Method to add a shadow for UIView object
     */
    func addShadow(_ color : UIColor = .gray,_ opacity : Float = 1, _ offset : CGSize = .zero , radius : CGFloat = 10){
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
        self.clipsToBounds = false
    }
}
