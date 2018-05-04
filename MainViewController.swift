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

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let model:EventsModel = EventsModel.sharedInstance
    let formatter = DateFormatter()
    
    @IBOutlet weak var JTC: JTAppleCalendarView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var seeEventButton: UIButton!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var monthLabel: UILabel!
    
    var desiredDate = ""
    var currentDate = ""
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let today = Date()
        //let weekday = Calendar.current.component(.weekday, from: today)
        let month = Calendar.current.component(.month, from: today)
        //let date = Calendar.current.component(.day, from: today)
        
        
        //label1.text = Calendar.current.weekdaySymbols[weekday-1]
        self.monthLabel.text = "\(Calendar.current.shortMonthSymbols[month-1])"
        
        /*
        //RESETTING SIMULATOR ---- DELETING USERDEFAULTS
        */
        
        //let appDomain = Bundle.main.bundleIdentifier!
        //UserDefaults.standard.removePersistentDomain(forName: appDomain)
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //log the user out and returns to home screen
    @IBAction func logOut(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    
    //opens up the imagepicker
    @IBAction func loadImageButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    //image picker delegate protocol
    //grabs the image chosen
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [String : Any]){
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
}

extension MainViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    
    //configures the calendar
    //uses the dateformatter declared at top of class to format date, timezone and locale
    //sets the calendar start and end date
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
       
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2018 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate,endDate: endDate)
        return parameters
    }
    
    //creates custom cell for calendar with a date label using the CustomCell class
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "Custom Cell", for: indexPath) as! CustomCell
        cell.dateLabel?.text = cellState.text
        return cell
    }
    
    //necessary function for protocol but basically does same as function didSelectDate
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        // This function should have the same code as the cellForItemAt function
        let cell = cell as! CustomCell
        cell.dateLabel.text = cellState.text
    }
    
    //signals when a cell is tapped
    //changes the background color and sets date on cell
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let cell = cell as! CustomCell
        cell.backgroundColor = UIColor.magenta
        self.desiredDate = formatter.string(from: date)
        print("what is the desired date? \(self.desiredDate)")
        checkForExistingEvents()
    }
    
    //checks if any events exist to enable/disable see events button
    func checkForExistingEvents(){
        if (model.numberEventsOnDay(date: self.desiredDate) == 0){
            self.seeEventButton.isEnabled = false
        }else{
            self.seeEventButton.isEnabled = true //FOR TESTING CHANGE TO FALSE
        }
    }
    
    //deselects date and changes background color back to original
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let cell = cell as! CustomCell
        cell.backgroundColor = UIColor(displayP3Red: 52, green: 45, blue: 89, alpha: 0)
        self.desiredDate = ""
        checkForExistingEvents()
    }
    
    //performs a segue to eventsofday view controller
    @IBAction func seeEvent(_ sender: Any) {
        self.performSegue(withIdentifier: "EventsOfDay", sender: self)
    }
    
    //prepares segue and looks for 2 different kinds of segues
    //one segue leads to table view for the events of the day
    //other segue leads to adding a new event
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventsOfDay"{
            let nav = segue.destination as! UINavigationController
            let destSeeEventsVC = nav.topViewController as! EventsOfDayTableViewController
            destSeeEventsVC.selectedDate = self.desiredDate
        }
        else if segue.identifier == "AddEvent"{
            let addVC = segue.destination as! AddEventViewController
            addVC.selectedDate = self.desiredDate
        }
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


