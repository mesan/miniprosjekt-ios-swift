//
//  Spill.swift
//  First Charade
//
//  Created by Mikkel Steine on 22/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation

class Spill {
    let rundetider = [5, 10, 20, 30, 60, 90, 120, 180] // sekunder
    let ordbøker = [
        "Matretter",
        "Dyr",
        "Programmeringspråk",
        "Drikkevarer",
        "Land"
    ]
    let ord = [
        ["Bacalao", "Spagetti bolognese", "Pizza", "Fenalår", "Surstrømming"],
        ["Elefant", "Mus", "Ulv", "Sau", "Sommerfugl", "Dinosaur"],
        ["C++", "ASM", "Swift", "Perl", "JavaScript", "Java"],
        ["Øl", "Karsk", "Cola", "Vodka", "Te", "Kaffe", "Vann"],
        ["Norge", "Sverige", "Danmark", "USA", "Russland", "India", "Kina", "Egypt"]
    ]

    var rundetid:Int = 30
    var ordbok:Int = 0
    var valgtOrd:String = ""

    func ordbokNavn() -> String {
        if (ordbok >= 0 && ordbok < ordbøker.count) {
            return ordbøker[ordbok]
        }
        return ""
    }
    
    func hentNesteOrd() -> String {
        if (ordbok < 0 || ordbok > ord.count) {
            ordbok = 0
        }
        let tilfeldigIndeks = Int(arc4random_uniform(UInt32(ord[ordbok].count)))
        valgtOrd = ord[ordbok][tilfeldigIndeks]
        return valgtOrd
    }

}