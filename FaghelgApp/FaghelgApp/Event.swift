//
//  Event.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation

class Event {
    var start: NSDate!
    var end: NSDate!
    var title: String!
    var description: String?
    var hostNames: String?
    var responsible: Person!
    var tags: String?
    
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