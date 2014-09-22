//
//  Spill.swift
//  First Charade
//
//  Created by Mikkel Steine on 22/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation

class Spill {
    let rundeTid:Int = 5 // sekunder
    // TODO: fyll oppgaveord fra ordbok
    var oppgaveord = ["ord 1", "ord 2", "ord 3", "et langt ord men ikke ekstremt", "et ekstremt langt ord som skulle vært i fnutter"]

    init() {
        
    }
    
    func ordbøker() {
        
    }
    
    func hentNesteOrd() -> String {
        let tilfeldigIndeks = Int(arc4random_uniform(UInt32(oppgaveord.count)))
        return oppgaveord[tilfeldigIndeks]
    }
}