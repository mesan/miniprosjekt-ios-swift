//
//  ViewController.swift
//  First Charade
//
//  Created by Olav Henriksen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

enum rundeStatuser {
    case velgOrd
    case igang
    case vunne
    case tapt
}

class ViewController: UIViewController {

    let rundeTid = 60 // sekunder
    var oppgaveord = ["ord 1", "ord 2", "ord 3", "ord 4", "ord 5"]
    
    var rundeStatus = rundeStatuser.velgOrd
    
    let timer = NSTimer()
    
    // MARK: Outlets
    @IBOutlet var valgtOppgaveord:UILabel!
    
    // MARK: Constructor / Destructor
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Timer
    
    // MARK: Actions
    @IBAction func testknapp(sender:UIButton) {
        valgtOppgaveord.text = "hei"
    }
    
    @IBAction func velgOrd(sender:UIButton) {
        // Velg ord runden skal begynne med
    }
    
    @IBAction func startRunde() {
        // Bytt bakgrunnsfarge til blå
        // Vis gjenstgående tid med hvit tekst
        // Start timer
    }
    
    @IBAction func nesteOrd(sender:UIButton) {
        // Vis rundeord
    }
    
    @IBAction func stoppRunde() {
        // Stopp timer
        // Bytt bakgrunnsfarge til grønn
        // Vis rundeord
    }
    
    @IBAction func gameOver() {
        // Stopp timer
        // Bytt bakgrunnsfarge til rød
        // vis rundeord
        // spill sørgemars
    }

}

