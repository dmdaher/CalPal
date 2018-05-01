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
    let formatter = DateFormatter()
    @IBOutlet weak var JTC: JTAppleCalendarView!
    
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var monthLabel: UILabel!
    
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
        print("hi")
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


