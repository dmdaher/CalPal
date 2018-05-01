//
//  Event.swift
//  CalPal
//
//  Created by Devin Daher on 5/1/18.
//  Copyright © 2018 Devin Daher. All rights reserved.
//

import Foundation
import UIKit

class Event: NSObject{
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
    
    private var title : String {
        set(newTitle){
            self.title = newTitle
        }
        get{
            return self.title
        }
    }
    private var color : UIColor{
        set(newColor){
            self.color = newColor
        }
        get{
            return self.color
        }
    }
    private var startTime : String{
        set(newStartTime){
            self.startTime = newStartTime
        }
        get{
            return self.startTime
        }
    }
    private var endTime : String{
        set(newEndTime){
            self.endTime = newEndTime
        }
        get{
            return self.endTime
        }
    }
    
    private var period: String{
        set(newPeriod){
            self.period = newPeriod
        }
        get{
            return self.period
        }
    }

}
