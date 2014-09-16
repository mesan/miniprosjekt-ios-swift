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
    var description: String!
    var hostNames: String?
    var responsible: Responsible!
    var tags: String?
}