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
    
    func numberOfDaysWithEvents() -> Int{
        return events.count
    }
    
    func eventAtIndex(date:String, index: Int) -> Event?{
        guard let eventDayArr = events[date] else{return nil}
        if(eventDayArr.count == 0 || index < 0 || index >= eventDayArr.count){return nil}
        else{
            return eventDayArr[index]
        }
    }
    
    func numberEventsOnDay(date:String) -> Int{
        guard let dayEventsArray = events[date] else{return 0}
        return dayEventsArray.count
    }
    
    func getEvents(date:String) -> [Event]?{
        return UserDefaults.standard.object(forKey: date) as? [Event]
    }
    
    func addEvents(date:String, event: Event){
        events[date]?.append(event)
        UserDefaults.standard.set(event, forKey: date) //IS THIS THE RIGHT WAY??
        print("the event date here is: \(date) and the event title is \(event.title)")
    }
    
    func removeEvent(date: String, index: Int){
        guard var dayEventsArray = events[date] else{return}
        if(dayEventsArray.count > 0){
            if(index < dayEventsArray.count && index >= 0){
                dayEventsArray.remove(at: index)
            }
        }
    }
    
    //reading the event for the day
    //adding event for a day
    //USerDefaults.standard.set(Object: x, forKey: Y)
}
