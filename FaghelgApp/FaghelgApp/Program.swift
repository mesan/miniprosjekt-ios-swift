//
//  Program.swift
//  FaghelgApp
//
//  Created by Lars Kristian Nymoen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation
import CoreData

class Program: NSManagedObject {

    @NSManaged var numberOfEvents: NSNumber
    @NSManaged var events: NSSet
    
    init(dict: NSDictionary) {
        numberOfEvents = dict["numberOfEvents"] as? Int
        
        events = []
        var eventsDict: NSArray = dict["events"] as NSArray
        for eventDict in eventsDict as [NSDictionary] {
            events!.append(Event(dict: eventDict));
        }
    }
}
