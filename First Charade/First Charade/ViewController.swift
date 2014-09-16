//
//  ViewController.swift
//  First Charade
//
//  Created by Olav Henriksen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let rundeTid = 60 // sekunder
    var oppgaveord = ["ord 1", "ord 2", "ord 3", "ord 4", "ord 5"]
    
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
    
    @IBAction func nyttOrd(sender:UIButton) {
        valgtOppgaveord.text = "hei"
    }
    
    // Starter timer
    @IBAction func startRunde() {
        valgtOppgaveord.text = "hei"
    }
    
    

}

