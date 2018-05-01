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
        
    }
    
    func numberOfEvents(){
        
    }
    
}
