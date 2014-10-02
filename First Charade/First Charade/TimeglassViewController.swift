//
//  TimeglassViewController.swift
//  First Charade
//
//  Created by Olav Henriksen on 22/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

enum rundestatuser {
    case igang
    case vunnet
    case tapt
}

class TimeglassViewController: UIViewController {
    @IBOutlet var tidIgjenLabel : UILabel!

    var timer = NSTimer()
    var tidIgjen : Int = 10
    var rundeStatus = rundestatuser.igang
    var rundeord : String = ""
    var gjenstaendeRundeTid : Int = 0

    var spill: Spill!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.spill = appDelegate.spill

        rundeord = spill.valgtOrd
        tidIgjen = spill.rundetid
        visGjenståendeTid()

        startRunde()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        timer.invalidate()
    }
    
    func startRunde() {
        let updateTime : Selector = "oppdaterGjenstaendeTid"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: updateTime, userInfo: nil, repeats: true)
        view.backgroundColor = UIColor.blueColor()
        gjenstaendeRundeTid = spill.rundetid
    }

    func oppdaterGjenstaendeTid() {
        tidIgjen--
        if (tidIgjen <= 0) {
            tapt()
        }
        visGjenståendeTid()
    }
    
    @IBAction func vunnet() {
        if (rundeStatus == .igang) {
            timer.invalidate()
            rundeStatus = .vunnet
            view.backgroundColor = UIColor(red:0.0, green:0.5, blue:0.0, alpha:1.0)
            visOrd()
        }
    }

    func tapt() {
        timer.invalidate()
        rundeStatus = .tapt
        view.backgroundColor = UIColor(red:0.5, green:0.0, blue:0.0, alpha:1.0)
        visOrd()
        // spill sørgemars
    }
    
    func visGjenståendeTid() {
        tidIgjenLabel.text = String(tidIgjen)
    }
    
    func visOrd() {
        tidIgjenLabel.text = rundeord
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
