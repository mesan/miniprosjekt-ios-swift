//
//  ProgramViewController.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController, UITableViewDataSource {
    
    var faghelgApi: FaghelgApi = FaghelgApi()
    @IBOutlet weak var tableView: UITableView!
    var program : Program!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        registerNotifications()
        

        faghelgApi.getProgram()
    }
    
    func registerNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "programFetched:", name: Notifications.programNotificationId, object: nil)
    }
    
    func programFetched(notification: NSNotification) {
        var program: Program = notification.object as Program
        println(program.numberOfEvents)
        println(program.events)
        
        self.program = program;
        self.tableView.reloadData();
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (program != nil) {
            return program.numberOfEvents!
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        
        if (program.events != nil) {
            var event : Event! = program.events?[indexPath.row]
            cell.textLabel?.text = event.title
            cell.detailTextLabel?.text = event.description
        }
        
        return cell
    }
}
