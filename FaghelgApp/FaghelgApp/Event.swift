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

    @NSManaged var start: NSDate
    @NSManaged var end: NSDate
    @NSManaged var desc: String
    @NSManaged var title: String
    @NSManaged var hostNames: String
    @NSManaged var tags: String
    @NSManaged var responsible: Responsible

}
