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
    private var eventArr:[Event]
    private(set) var currentIndex: Int
    static let sharedInstance = EventsModel()
    
    override init(){
        events = [String:[Event]]()
        eventArr = [Event]()
        currentIndex = 0
    }
    
    //finds number of total days with at least 1 event
    func numberOfDaysWithEvents() -> Int{
        return events.count
    }
    
    //grabs event for a certain date
    func eventAtIndex(date:String, index: Int) -> Event?{
        guard let eventDayArr = events[date] else{return nil}
        if(eventDayArr.count == 0 || index < 0 || index >= eventDayArr.count){return nil}
        else{
            return eventDayArr[index]
        }
    }
    
    //grabs total number of events for a certain day
    func numberEventsOnDay(date:String) -> Int{
        print("in numberEventsOnDay and date is: \(date)")
        //guard let dayEventsArray = events[date] else{return 0}
        //print("the count is : \(dayEventsArray.count)")
        
        let userDefaults = UserDefaults.standard
        guard let eventDataEncoded:Data = userDefaults.object(forKey: date) as? Data else{return 0}
        print("nothing here :(")
        let unpackedEvent:[Event] = NSKeyedUnarchiver.unarchiveObject(with: eventDataEncoded) as! [Event]
        return unpackedEvent.count
        //return dayEventsArray.count
    }
    
    func getEvents(date:String, index:Int) -> Event{
        
        let userDefaults = UserDefaults.standard
        let eventDataEncoded:Data = userDefaults.object(forKey: date) as! Data
        let unpackedEvent:[Event] = NSKeyedUnarchiver.unarchiveObject(with: eventDataEncoded) as! [Event]
        print("Returning the unpacked event with title: \(unpackedEvent[0].title)")
        return unpackedEvent[index]
    }
    
    func addEvents(date:String, event: Event){
        let userDefaults = UserDefaults.standard
        guard let savedEventArr:Data = userDefaults.object(forKey: date) as? Data else{
            print("in the else of the guard....")
            var newArr = [Event]()
            newArr.append(event)
            events[date] = newArr
            let encodedNewArr = NSKeyedArchiver.archivedData(withRootObject: newArr)
            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedNewArr, forKey: date)
            userDefaults.synchronize()
            print("######### the dictionary count is now: \(events.count) and the array size at this date is: \(newArr.count)")
            return
        }
        var currUnpackedEvents:[Event] = NSKeyedUnarchiver.unarchiveObject(with: savedEventArr) as! [Event]
        print("the event date here is: \(date) and the event title is \(event.title)")
        currUnpackedEvents.append(event)
        events[date] = currUnpackedEvents
        
        //save the new array of events to local machine
        let encodedNewArr = NSKeyedArchiver.archivedData(withRootObject: currUnpackedEvents)
        userDefaults.set(encodedNewArr, forKey: date)
        userDefaults.synchronize()
        print("######### the dictionary count is now: \(currUnpackedEvents.count) and the array size at this date is: \(currUnpackedEvents.count)")
        userDefaults.synchronize()
    }
    
    func removeEvent(date: String, index: Int){
        guard var dayEventsArray = events[date] else{return}
        if(dayEventsArray.count > 0){
            if(index < dayEventsArray.count && index >= 0){
                dayEventsArray.remove(at: index)
            }
        }
    }
}
