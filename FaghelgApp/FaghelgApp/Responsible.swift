//
//  Responsible.swift
//  FaghelgApp
//
//  Created by Lars Kristian Nymoen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation
import CoreData

class Responsible: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var fullName: String
    @NSManaged var shortName: String

}
