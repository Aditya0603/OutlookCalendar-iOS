//
//  CalendarViewController.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/10/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    // calendar collection view to show top dates
    @IBOutlet weak var calendarCollectionView : UICollectionView?
    // bg view to show Shadow
    @IBOutlet weak var calendarCollectionBgView : UIView?
    // height constraint for the collection view
    @IBOutlet weak var heightConstraint : NSLayoutConstraint?
    // the below events table VC
    var eventsTableVC : EventsTableViewController?
    // bool to store state if collection view is expanded or contracted
    var isContracted = false
    // manager to get date models
    let dayManager = DayManager()
    // array to hole date model objects
    var dateModelArr = [DateModel]()
    // for the selected index path to show add eventsVC and to scroll events to selected indexPath
    var selectedIndexPath : IndexPath?
    // gesture to expand and contract collection view
    var calendarCollectionViewPanGesture : UIPanGestureRecognizer?
    // var to store the height of cell to later expand and contract
    var heightOfCell : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // collection view's layout
        configureCollectionViewLayout()
        // add gesture for colection view expanding
        addExpandContractGesture()
        // fetch Date Model objects
        fetchData()
        // Add Navigation toolbar items
        configureToolBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the segue destination for eventsTable VC and store it
        // assign self as the delegate to listen to scroll events
        if segue.identifier == Constants.eventsTableSegue{
            if let eventsTableVC = segue.destination as? EventsTableViewController{
                self.eventsTableVC = eventsTableVC
                self.eventsTableVC?.eventsDelegate = self
                self.eventsTableVC?.reloadWithDateModelArr(self.dateModelArr)
            }
        }
    }
    
    /*
     Method to set the collection view layout
     divide in 7 cells width wise as per the views width
     */
    func configureCollectionViewLayout() {
        calendarCollectionBgView?.addShadow()
        calendarCollectionView?.dataSource = self
        calendarCollectionView?.delegate = self
        if let flow = calendarCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            let viewWidth = self.view.bounds.size.width
            heightOfCell = viewWidth/7
            flow.itemSize = CGSize(width:heightOfCell, height:heightOfCell)
            flow.minimumInteritemSpacing = 0
            flow.minimumLineSpacing = 0
        }
    }
    
    func addExpandContractGesture() {
        calendarCollectionViewPanGesture = UIPanGestureRecognizer(target:self,action:#selector(CalendarViewController.collectionViewPanned(_:)))
        if let calendarCollectionViewPanGesture = calendarCollectionViewPanGesture{
            calendarCollectionViewPanGesture.isEnabled = false
            calendarCollectionView?.addGestureRecognizer(calendarCollectionViewPanGesture)
        }
    }
    
    func fetchData(){
        weak var weakSelf = self
        dayManager.getDateModelsForCalendar { (dateModelArr, error) in
            if let dateModelArr = dateModelArr{
                // If we have the date model reload collecdtion view and table view
                weakSelf?.dateModelArr = dateModelArr
                weakSelf?.calendarCollectionView?.reloadData()
                weakSelf?.eventsTableVC?.reloadWithDateModelArr(weakSelf?.dateModelArr)
                
                // wait for reload and select today in the collection view and scroll tableview to today
                let delayTime = DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                  weakSelf?.higlightToday()
                }
            }
        }
    }
    
    //Method to highlight today
    func higlightToday(){
        let today = Date()
        // Find today's index and select that i colection view and scroll to the section in tableView
        // Hard coded and might not be the ideal way to do it
        let indexForToday = 90+today.weekDay
        selectedIndexPath = IndexPath(row:indexForToday,section:0)
        calendarCollectionView?.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
        eventsTableVC?.tableView.scrollToRow(at: IndexPath(row:0,section:indexForToday), at: .top, animated: false)
    }
    
    // Method to add + button on navigation
    func configureToolBar() {
        let toolBarItem = UIBarButtonItem(barButtonSystemItem:.add,target:self,action:#selector(CalendarViewController.addEvent(_:)))
        self.navigationItem.rightBarButtonItem = toolBarItem
    }
    @objc func addEvent(_ sender: Any){
            // Show Add eventsVC
    }
    
    /*
     Gesture that collection view is panned
     If contracted expand the collection View
     */
    @objc func collectionViewPanned(_ gesture: UIPanGestureRecognizer){
        expandCollectionView()
    }
    
    func contractCollectionView(){
        // if collection view is not  Contracted contract it
        if !isContracted{
            self.calendarCollectionViewPanGesture?.isEnabled = true
            self.calendarCollectionView?.isScrollEnabled = false
            // Contract to show only 2 rows
            self.heightConstraint?.constant = (heightOfCell * 2)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isContracted = true
    }
    
    func expandCollectionView() {
        // if collection view is Contracted exapnd it
        if isContracted{
            calendarCollectionViewPanGesture?.isEnabled = false
            calendarCollectionView?.isScrollEnabled = true
            // expand to show only 5 rows
            self.heightConstraint?.constant = (heightOfCell * 5)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isContracted = false
    }
}

extension CalendarViewController : EventsTableViewDelegate{
    
    func eventsTableViewScrolledToIndex(_ section: Int) {
        // Called on header view did Show of Events table View
        // Select a date for the header view index in collection view
        selectedIndexPath = IndexPath(row:section,section:0)
        calendarCollectionView?.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .bottom)
    }
    
    func eventsTableViewScrolled(){
        // Called on Each Scroll, Contract collection View
        contractCollectionView()
    }
}
extension CalendarViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // scroll eventstableVC to the section as the indexpath row here is date
        // in eventstableVC it is a section for the date and rows are the events
        self.eventsTableVC?.tableView.scrollToRow(at: IndexPath(row:0,section:indexPath.row), at: .top, animated: false)
        selectedIndexPath = indexPath
    }
}

extension CalendarViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateModelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionCell.DayCell.rawValue, for: indexPath) as! DayCollectionViewCell
        let dateModel = dateModelArr[indexPath.row]
        cell.dayLabel?.text = dateModel.smallDateValue
        // Small logic to change collection cell background color
        if let month = dateModel.month, month % 2 == 0{
            cell.backgroundColor = Constants.veryLightGrayColor
        }
        else{
            cell.backgroundColor = .white
        }
        return cell
    }
    
    
}
