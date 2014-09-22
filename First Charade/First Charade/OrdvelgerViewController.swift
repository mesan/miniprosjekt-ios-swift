//
//  OrdvelgerViewController.swift
//  First Charade
//
//  Created by Olav Henriksen on 22/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class OrdvelgerViewController: UIViewController {
    var oppgaveord = ["ord 1", "ord 2", "ord 3", "et langt ord men ikke ekstremt", "et ekstremt langt ord som skulle vært i fnutter"]
    
    @IBOutlet var timeglass : TimeglassViewController!
    @IBOutlet var valgtOrd : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nesteOrd() {
            let tilfeldigIndeks = Int(arc4random_uniform(UInt32(oppgaveord.count)))
            valgtOrd.text = oppgaveord[tilfeldigIndeks]
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
