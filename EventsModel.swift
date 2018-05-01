//
//  EventsModel.swift
//  CalPal
//
//  Created by Devin Daher on 5/1/18.
//  Copyright © 2018 Devin Daher. All rights reserved.
//

import UIKit
import Foundation

class EventsModel: NSObject{
    private var events:[String:[Event]] //dictionary with array of events
    private(set) var currentIndex: Int
    static let sharedInstance = EventsModel()
    
    override init(){
        events = [String:[Event]]()
        currentIndex = 0
        let e1 = Event(title: "Test", color: UIColor.green, startTime: "12:30", endTime: "1:30", period: "pm")
        
    }
    
    func numberOfEvents(){
        
    }
    
    func getEvents(date:String) -> [Event]?{
        return UserDefaults.standard.object(forKey: date) as? [Event]
    }
    //reading the event for the day
    //adding event for a day
    //USerDefaults.standard.set(Object: x, forKey: Y)
}
