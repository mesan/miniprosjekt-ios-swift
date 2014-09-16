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
        
        faghelgApi.getProgram()
    }
    
}
