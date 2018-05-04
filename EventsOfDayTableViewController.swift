//
//  EventsOfDayTableViewController.swift
//  CalPal
//
//  Created by Devin Daher on 5/2/18.
//  Copyright © 2018 Devin Daher. All rights reserved.
//

import UIKit

class EventsOfDayTableViewController: UITableViewController {


    @IBOutlet weak var cancelButton: UIBarButtonItem!
    let model:EventsModel = EventsModel.sharedInstance
    
    var selectedDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        print("in EventsOFDayVC, the selectedDate passed in is: \(self.selectedDate)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    @IBAction func cancel(_ sender: Any) {
        self.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    //Update table view
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.numberEventsOnDay(date: self.selectedDate)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allEvents", for: indexPath)
        
       
        let e1:Event =  model.getEvents(date: self.selectedDate, index: indexPath.row)
//        let e1:Event = (model.eventAtIndex(date: self.selectedDate, index: indexPath.row))!
        let tableCellText = e1.title
        let detailTableCellText = e1.startTime
        cell.detailTextLabel?.text = detailTableCellText
        cell.detailTextLabel?.textColor = UIColor.black
        cell.textLabel?.text = tableCellText
        //cell.textLabel?.textColor = UIColor.white
        print("what is the start time? \(e1.startTime)" )
        //cell.detailTextLabel?.text = e1.startTime + e1.period + " - " + e1.endTime + " " + e1.period
        cell.backgroundColor = e1.color
        
        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.model.removeEvent(date: self.selectedDate, index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
