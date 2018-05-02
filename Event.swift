//
//  Event.swift
//  CalPal
//
//  Created by Devin Daher on 5/1/18.
//  Copyright © 2018 Devin Daher. All rights reserved.
//

import Foundation
import UIKit

class Event: NSObject, NSCoding{
    

    
    override init(){
        self.title = "default"
        self.color = UIColor.blue
        self.startTime = "12:00"
        self.endTime = "1:00"
        self.period = "pm"
    }
    
    init(title: String, color: UIColor, startTime: String, endTime: String, period: String){
        self.title = title
        self.color = color
        self.startTime = startTime
        self.endTime = endTime
        self.period = period
    }
    
    var title : String
    var color : UIColor
    var startTime : String
    var endTime : String
    var period: String
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(color, forKey: "color")
        aCoder.encode(startTime, forKey: "startTime")
        aCoder.encode(endTime, forKey: "endTime")
        aCoder.encode(period, forKey: "period")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.color = aDecoder.decodeObject(forKey: "color") as! UIColor
        self.startTime = aDecoder.decodeObject(forKey: "startTime") as! String
        self.endTime = aDecoder.decodeObject(forKey: "endTime") as! String
        self.period = aDecoder.decodeObject(forKey: "period") as! String
    }
    
    func initWithCoder(aDecoder: NSCoder) -> Event{
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.color = aDecoder.decodeObject(forKey: "color") as! UIColor
        self.startTime = aDecoder.decodeObject(forKey: "startTime") as! String
        self.endTime = aDecoder.decodeObject(forKey: "endTime") as! String
        self.period = aDecoder.decodeObject(forKey: "period") as! String
        return self
    }

}
