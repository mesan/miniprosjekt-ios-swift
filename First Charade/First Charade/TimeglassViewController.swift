//
//  TimeglassViewController.swift
//  First Charade
//
//  Created by Olav Henriksen on 22/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class TimeglassViewController: UIViewController {
    @IBOutlet var tidIgjenLabel : UILabel!
    var timer = NSTimer()
    var tidIgjen = 10

    var spill: Spill!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visGjenståendeTid()
        let updateTime : Selector = "oppdaterGjenstaendeTid"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: updateTime, userInfo: nil, repeats: true)

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.spill = appDelegate.spill
        tidIgjen = spill.rundetid
        visGjenståendeTid()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        timer.invalidate()
    }
    
    func oppdaterGjenstaendeTid() {
        tidIgjen--
        if (tidIgjen <= 0) {
            tapt()
        }
        visGjenståendeTid()
    }
    
    func visGjenståendeTid() {
        tidIgjenLabel.text = String(tidIgjen)
    }
    
    @IBAction func vunnet() {
        self.performSegueWithIdentifier("vunnet", sender: self)
    }

    func tapt() {
        self.performSegueWithIdentifier("tapt", sender: self)
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
