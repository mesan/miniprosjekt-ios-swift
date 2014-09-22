//
//  Person.swift
//  FaghelgApp
//
//  Created by Lars Kristian Nymoen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation
import CoreData

class Person: NSManagedObject {

    @NSManaged var id: String?
    @NSManaged var shortName: String?
    @NSManaged var fullName: String?
    
    func setData(dict: NSDictionary) {
        id = dict["id"] as? String
        fullName = dict["fullName"] as? String
        shortName = dict["shortName"] as? String
    }
}
