//
//  Responsible.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation

class Person {
    var id: String?
    var fullName: String?
    var shortName: String?
    
    init(dict: NSDictionary) {
        id = dict["id"] as? String
        fullName = dict["fullName"] as? String
        shortName = dict["shortName"] as? String
    }
}
