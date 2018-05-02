//
//  AddEventViewController.swift
//  CalPal
//
//  Created by Devin Daher on 5/2/18.
//  Copyright © 2018 Devin Daher. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UITextFieldDelegate {
    let model:EventsModel = EventsModel.sharedInstance
    let formatter = DateFormatter()
    
    var selectedDate = ""
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var periodLabel: UITextField!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var invalidInputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.delegate = self
        print("what is selected date in add Vc? \(self.selectedDate) AYY")
        self.formatter.dateFormat = "HH:mm"
        let timeOne = "12:30"
        let timeTwo = "1:30"
        self.invalidInputLabel.text = ""
        self.titleLabel.text = ""
        self.startTimePicker.date = self.formatter.date(from: timeOne)!
        self.endTimePicker.date = self.formatter.date(from: timeTwo)!
        self.colorSegmentedControl.selectedSegmentIndex = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //when title is filled, save all the fields, create an event, and add it to user's events
    @IBAction func save(_ sender: Any) {
        guard let eventTitle = self.titleLabel.text else{
            return
        }
        if eventTitle.isEmpty{
            self.invalidInputLabel.text = "Error. Must input event title"
        }else{
            self.invalidInputLabel.text = ""
            guard let newTitle = self.titleLabel.text else{return}
            let newStartTime = self.formatter.string(from: self.startTimePicker.date)
            let newEndTime = self.formatter.string(from: self.endTimePicker.date)
            let newColorStr:String = self.colorSegmentedControl.titleForSegment(at: self.colorSegmentedControl.selectedSegmentIndex)!
            print("newColor is: \(newColorStr)")
            let newColor:UIColor = determineColor(colorStr: newColorStr)
            let newEvent = Event(title: newTitle, color: newColor, startTime: newStartTime, endTime: newEndTime, period: "pm")
            model.addEvents(date: self.selectedDate, event: newEvent)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //figure out what color user chose for their event
    func determineColor(colorStr:String)->UIColor{
        switch (colorStr) {
        case "Red":
            return UIColor.red
        case "Blue":
            return UIColor.cyan
        case "Green":
            return UIColor(displayP3Red: 14, green: 171, blue: 7, alpha: 0)
        case "Yellow":
            return UIColor.yellow
        case "Purple":
            return UIColor.purple
        default:
            return UIColor.red
        }
    }
    
    //delegate for textfield
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        let changedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if string == "\n"{
            textField.resignFirstResponder()
            return false
        }else{
            checkIfFieldsAreEmpty(titleText: changedString)
            return true
        }
    }
    
    //check if the title is empty and if so, disable save button
    func checkIfFieldsAreEmpty(titleText:String){
        if(titleText.isEmpty == false){
            self.saveButton.isEnabled = true
        }
        else{
            self.saveButton.isEnabled = false
        }
    }
    
    //send back to calendar page
    @IBAction func cancelButton(_ sender: Any) {
        self.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    //dismiss keyboard
    @IBAction func backgroundButton(_ sender: Any) {
        if(self.titleLabel.isFirstResponder){
            self.titleLabel.resignFirstResponder()
        }
        else if (self.startTimePicker.isFirstResponder){
            self.startTimePicker.resignFirstResponder()
        }
        else if(self.endTimePicker.isFirstResponder){
            self.endTimePicker.resignFirstResponder()
        }
        else{
            self.colorSegmentedControl.resignFirstResponder()
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

}


