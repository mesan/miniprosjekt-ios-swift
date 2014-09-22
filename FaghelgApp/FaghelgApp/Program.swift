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

    @NSManaged var numberOfEvents: NSNumber!
    @NSManaged var events: NSMutableSet!
    
    func setData(dict: NSDictionary) {

        numberOfEvents = dict["numberOfEvents"] as? Int
        
        events = NSMutableSet()
        var eventsDict: NSArray = dict["events"] as NSArray
        for eventDict in eventsDict as [NSDictionary] {
            var event = Event(entity: NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)!, insertIntoManagedObjectContext: self.managedObjectContext)
            event.setData(eventDict)
            
            events!.addObject(event)
        }
    }
}
