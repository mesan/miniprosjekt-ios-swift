//
//  RundeTaptViewController.swift
//  First Charade
//
//  Created by Olav Henriksen on 22/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class RundeTaptViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startNesteRunde() {
        self.performSegueWithIdentifier("ny runde", sender: self)
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
