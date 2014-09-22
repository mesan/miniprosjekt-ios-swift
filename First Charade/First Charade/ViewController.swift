//
//  ViewController.swift
//  First Charade
//
//  Created by Olav Henriksen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

enum rundestatuser {
    case velgOrd
    case igang
    case vunnet
    case tapt
}

class ViewController: UIViewController {
    
    @IBOutlet var velgord:OrdvelgerViewController!

    var spill: Spill!
    
    // MARK: runde skal refaktoreres til egen runde-klasse
    var rundeTimer = NSTimer()
    var rundeStatus = rundestatuser.velgOrd
    var rundeord = ""
    var gjenstaendeRundeTid: Int = 0
    
    // MARK: Outlets
    @IBOutlet var valgtOppgaveord:UILabel!
    
    // MARK: Constructor / Destructor
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.spill = appDelegate.spill
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Timer
    
    // MARK: Actions
    @IBAction func testknapp(sender:UIButton) {
//        velgOrd()
//        startRunde()
    }

//TODO: Lag funksjonalitet for å bestemme antall sekunder i rundetiden
    
    @IBAction func velgOrd() {
        nesteOrd()
    }
    
    @IBAction func startRunde() {
        if (rundeStatus == .velgOrd) {
            rundeStatus = .igang
            view.backgroundColor = UIColor.blueColor()
            gjenstaendeRundeTid = spill.rundeTid
            startTimer()
        }
    }
    
    func startTimer() {
        valgtOppgaveord.text = ""
        rundeTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        gjenstaendeRundeTid--
        valgtOppgaveord.text = String(gjenstaendeRundeTid)
        if (gjenstaendeRundeTid < 1) {
            gameOver()
        }
    }
    
    @IBAction func nesteOrd() {
        if (rundeStatus == .vunnet || rundeStatus == .tapt) {
            rundeStatus = .velgOrd
            view.backgroundColor = UIColor.blackColor()
        }
        if (rundeStatus == .velgOrd) {
            rundeord = spill.hentNesteOrd();
            visOrd()
        }
    }
    
    @IBAction func stoppRunde() {
        if (rundeStatus == .igang) {
            rundeTimer.invalidate()
            rundeStatus = .vunnet
            view.backgroundColor = UIColor.greenColor()
            visOrd()
        }
    }
    
    @IBAction func gameOver() {
        rundeTimer.invalidate()
        rundeStatus = .tapt
        view.backgroundColor = UIColor.redColor()
        visOrd()
        // spill sørgemars
    }
    
    func visOrd() {
        valgtOppgaveord.text = rundeord
    }

}

