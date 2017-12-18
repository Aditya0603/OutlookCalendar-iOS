//
//  MonthTableViewCell.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/6/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

/*
 This class is for the infinite date view
 Not being used but  if you switch to ViewController class this cell will be used
 */

protocol DaySelectedProtocol : class {
    func daySelected(_ date : Int)
}

class MonthTableViewCell: UITableViewCell {
    
    // CollectionView to show 
    @IBOutlet weak var monthCollectionView : UICollectionView?
    
    // Delegate to notify selection of a collection view cell
    weak var selectionDelegate : DaySelectedProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MonthTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Need to show max 35 days
        // Need to handle for ideal feburary :P
        return 7*5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCollectionViewCell
        cell.dayLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
    
    
}

extension MonthTableViewCell : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionDelegate?.daySelected(indexPath.row)
    }
}
