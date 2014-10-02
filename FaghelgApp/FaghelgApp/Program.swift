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
    
    var fetchedEventController : NSFetchedResultsController = NSFetchedResultsController()
    
    func setData(dict: NSDictionary) {

        numberOfEvents = dict["numberOfEvents"] as? Int
        
        events = NSMutableSet()
        
        var eventsDict: NSArray = dict["events"] as NSArray
        for eventDict in eventsDict as [NSDictionary] {
            var event = Event(entity: NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)!, insertIntoManagedObjectContext: self.managedObjectContext)
            events.addObject(event)
            event.setData(eventDict)
            
        }
        self.managedObjectContext.save(nil)
    }
    
    func deleteProgram() {
        
    }
    
    func getAllEvents() -> NSArray{
        
        //return events.allObjects
        
        //MÅ BEARBEIDES
        self.fetchedEventController = self.getEventsResultsController()
        self.fetchedEventController.performFetch(nil)
        
        return self.fetchedEventController.fetchedObjects!
    }
    
    func getEventsResultsController() -> NSFetchedResultsController{
        fetchedEventController = NSFetchedResultsController(fetchRequest: eventsTaskRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedEventController
    }
    

    func eventsTaskRequest() -> NSFetchRequest {
        let eventRequest = NSFetchRequest(entityName: "Event")
        let sortDescriptor = NSSortDescriptor(key: "start", ascending: true)
        eventRequest.sortDescriptors = [sortDescriptor]
        return eventRequest
    }
}
