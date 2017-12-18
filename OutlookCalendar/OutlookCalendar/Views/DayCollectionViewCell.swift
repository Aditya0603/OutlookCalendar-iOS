//
//  DayCollectionViewCell.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/6/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    // label to show the date
    @IBOutlet weak var dayLabel : UILabel?
    override func layoutSubviews() {
        if let dayLabel = dayLabel{
            // create a rounded label
            dayLabel.clipsToBounds = true
            dayLabel.layer.cornerRadius = dayLabel.frame.size.width/2
        }
    }
    override var isSelected: Bool{
        // If Cell is Selected reload UI for the cell
        didSet{
            if isSelected{
                dayLabel?.backgroundColor = .blue
                if let dayLabel = dayLabel{
                    dayLabel.clipsToBounds = true
                    // i know this is repetition of code but a weird transition was happening without this
                    // label was not becoming circular
                    dayLabel.layer.cornerRadius = dayLabel.frame.size.width/2
                    dayLabel.textColor = .white
                }
            }
            else{
                dayLabel?.backgroundColor = .clear
                dayLabel?.textColor = .black
            }
        }
    }
}

