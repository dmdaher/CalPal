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
    
    var title : String
    var color : UIColor
    var startTime : String
    var endTime : String
    var period: String

}
