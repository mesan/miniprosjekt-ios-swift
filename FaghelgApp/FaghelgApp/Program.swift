//
//  Program.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation

class Program {
    var numberOfEvents: Int?
    var events: [Event]?
    
    init(dict: NSDictionary) {
        numberOfEvents = dict["numberOfEvents"] as? Int
        
        events = []
        var eventsDict: NSArray = dict["events"] as NSArray
        for eventDict in eventsDict as [NSDictionary] {
            events!.append(Event(dict: eventDict));
        }
    }
}
