//
//  EventsTableViewController.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/10/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit


protocol EventsTableViewDelegate : class {
    func eventsTableViewScrolledToIndex(_ section : Int)
    func eventsTableViewScrolled()
}

class EventsTableViewController: UITableViewController {
    weak var eventsDelegate : EventsTableViewDelegate?
    var dateModelArr : [DateModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadWithDateModelArr(_ dateModelArr : [DateModel]?) {
        self.dateModelArr = dateModelArr
        self.tableView.reloadData()
    }
}

// MARK: - Table view data source
extension EventsTableViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // have sections for each date
        return dateModelArr?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dateModel = dateModelArr?[section]
        // get the events from the section index for the given date model object
        // return the events count
        return dateModel?.eventModelArr?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        let dateModel = dateModelArr?[indexPath.section]
        if let _ = dateModel?.eventModelArr?.count, let eventModelArr = dateModel?.eventModelArr{
            if let eventCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableCell.DateCell.rawValue) as? DayEventTableViewCell{
                
             eventCell.populateWitEvent(event: eventModelArr[indexPath.row])
                cell = eventCell
            }
            else {
                //No cell configured , going to return a nil value empty cell-> will Crash
                //Please configure a cell
            }
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableCell.EmptyCell.rawValue, for: indexPath)
        }
        return cell
    }
}
// MARK: - Table view Delegate
extension EventsTableViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dateModel = dateModelArr?[indexPath.section]
        if let _ = dateModel?.eventModelArr?.count{
            return 90
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame : CGRect(x:0,y:0,width:tableView.bounds.size.width,height:40))
        label.backgroundColor = Constants.veryLightGrayColor
        label.font = Constants.eventsTableHeaderFont
        let dateModel = dateModelArr?[section]
        // Add today if date is today
        if let isToday = dateModel?.isToday, isToday == true{
            label.text = "   Today, \(dateModel?.longDateValue ?? "")"
            label.backgroundColor = Constants.veryLightBLUEColor
        }
        else{
            label.text = "   \(dateModel?.longDateValue ?? "")"
            label.backgroundColor = Constants.veryLightGrayColor
        }
        return label
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let visibleRows = tableView.indexPathsForVisibleRows, visibleRows.count > 0 {
            // call delgate method to notify scrolled to a new header index
            eventsDelegate?.eventsTableViewScrolledToIndex(visibleRows[0].section)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // call delgate method to notify scroll
        eventsDelegate?.eventsTableViewScrolled()
    }
}
