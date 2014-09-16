//
//  ProgramViewController.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {
    
    var faghelgApi: FaghelgApi = FaghelgApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "programFetched:", name: Notifications.programNotificationId, object: nil)

        faghelgApi.getProgram()
    }
    
    func programFetched(notification: NSNotification) {
        var program: Program = notification.object as Program
        println(program.numberOfEvents)
        println(program.events)
        
    }
}
