//
//  ViewController.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/6/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

/*
 This class is not being used but tried a lot with Hit and trial to make a inifnite collection view for dates
 Although the cells are right now hardcoded from 1.. 35
 In the daySelected Method tried Hit and trials to make the transition from one month to another look smooth
 This class only uses one cell and reloads it depending on the date user has selected
 
 To use this class set the root view controller of navigation as View controller in Main.storyboard
 */



class ViewController: UIViewController {

    @IBOutlet weak var calendarTableView : UITableView?
    @IBOutlet weak var calendarTableBgView : UIView?
    @IBOutlet weak var heightConstraint : NSLayoutConstraint?
    var eventsTableVC : EventsTableViewController?
    var months = [1]
    var isContracted = false
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarTableBgView?.addShadow()
        let panGesture = UIPanGestureRecognizer(target:self,action:#selector(ViewController.panned(_:)))
        self.view?.addGestureRecognizer(panGesture)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarTableView?.isPagingEnabled = true
    }
    
    @objc func panned(_ gesture: UIPanGestureRecognizer){
        isContracted = !isContracted
        if gesture.state == .began{
            self.heightConstraint?.constant = -200
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
//        }
//        if gesture.state == .ended{
            if isContracted{
            self.heightConstraint?.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.eventsTableSegue{
            if let eventsTableVC = segue.destination as? EventsTableViewController{
                self.eventsTableVC = eventsTableVC
            }
        }
    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return months.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell") as! MonthTableViewCell
        cell.selectionDelegate = self
        return cell
    }
    
    
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let calendarTableView = calendarTableView{
            return calendarTableView.bounds.size.height
        }
        return 300
    }
}

extension ViewController : DaySelectedProtocol{
    func daySelected(_ date : Int) {
        var movingUp = true
        
        self.months.append(1)
        self.calendarTableView?.beginUpdates()
        if date > 14{
            self.calendarTableView?.insertRows(at: [IndexPath(row:1,section:0)], with: .bottom)
        }
        else{
            movingUp = false
            self.calendarTableView?.insertRows(at: [IndexPath(row:0,section:0)], with: .top)
        }
        self.calendarTableView?.endUpdates()
        
        let delayTime = DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            
            self.months.remove(at: 0)
            
            self.calendarTableView?.beginUpdates()
            if date > 14{
                self.calendarTableView?.deleteRows(at: [IndexPath(row:0,section:0)], with: .top)
            }
            else{
                movingUp = false
                self.calendarTableView?.deleteRows(at: [IndexPath(row:1,section:0)], with: .none)
            }
            self.calendarTableView?.endUpdates()
            
            if !movingUp{
                self.calendarTableView?.scrollToRow(at: IndexPath(row:0,section:0), at: .bottom, animated: true)
            }
            
        }
    }
}
