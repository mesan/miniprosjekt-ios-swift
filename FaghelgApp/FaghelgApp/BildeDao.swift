//
//  BildeDao.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 02/10/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation
import CoreData

class BildeDao: NSManagedObject {
    
    @NSManaged var imageData: NSData
    @NSManaged var shortName: String
    
    func save() {
        self.managedObjectContext?.save(nil);
    }
    
    func rollback() {
        self.managedObjectContext?.rollback();
    }
    
    func getDescription() -> String {
        return "imageData: \(imageData), shortName: \(shortName)"
    }
}
