//
//  Event.swift
//  FaghelgApp
//
//  Created by Lars Kristian Nymoen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation
import CoreData

class Event: NSManagedObject {

    @NSManaged var start: NSDate!
    @NSManaged var end: NSDate!
    @NSManaged var desc: String!
    @NSManaged var title: String!
    @NSManaged var hostNames: String
    @NSManaged var tags: String?
    @NSManaged var responsible: Person!
    
    init(dict: NSDictionary) {
        let startTime = dict["start"] as Double
        start = NSDate(timeIntervalSince1970: startTime)
        let endTime = dict["end"] as Double
        end = NSDate(timeIntervalSince1970: endTime)
        title = dict["title"] as String
        description = dict["description"] as? String
        hostNames = dict["hostNames"] as? String
        var responsibleDict = dict["responsible"] as NSDictionary
        responsible = Person(dict: responsibleDict)
        tags = dict["tags"] as? String
    }
}
