//
//  MainViewController.swift
//  CalPal
//
//  Created by Devin Daher on 4/30/18.
//  Copyright © 2018 Devin Daher. All rights reserved.
//

import UIKit
import Firebase
import JTAppleCalendar

class MainViewController: UIViewController{
    let model:EventsModel = EventsModel.sharedInstance
    let formatter = DateFormatter()
    @IBOutlet weak var JTC: JTAppleCalendarView!
    
    @IBOutlet weak var seeEventButton: UIButton!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var monthLabel: UILabel!
    
    var desiredDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let day = Date()
//        let month = Date()
//        var dateArr = [Date]()
//        dateArr.append(day)
//        
//        JTC.scrollToDate(Date())
//        self.monthLabel.text = JTC.monthStatus(for: month)
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
}

extension MainViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
       
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2018 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate,endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "Custom Cell", for: indexPath) as! CustomCell
        cell.dateLabel?.text = cellState.text
        return cell
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        // This function should have the same code as the cellForItemAt function
        let cell = cell as! CustomCell
        cell.dateLabel.text = cellState.text
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let cell = cell as! CustomCell
        cell.backgroundColor = UIColor.magenta
        self.desiredDate = formatter.dateFormat
        print("what is the desired date? \(self.desiredDate) or what is the date in the func? \(date)")
        checkForExistingEvents()
    }
    
    func checkForExistingEvents(){
        if (model.numberEventsOnDay(date: self.desiredDate) == 0){
            self.seeEventButton.isEnabled = true
        }else{
            self.seeEventButton.isEnabled = false
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let cell = cell as! CustomCell
        cell.backgroundColor = UIColor(displayP3Red: 52, green: 45, blue: 89, alpha: 0)
        self.desiredDate = ""
        checkForExistingEvents()
    }
    
    func displayEvents(cell:CustomCell){
        
    }
    
    @IBAction func seeEvent(_ sender: Any) {
        self.performSegue(withIdentifier: "EventsOfDay", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destSeeEventsVC = segue.destination as! EventsOfDayTableViewController
        
        destSeeEventsVC.selectedDate = self.desiredDate
    }
    
    
}
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


