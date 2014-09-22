//
//  ProgramViewController.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var faghelgApi: FaghelgApi = FaghelgApi()
    @IBOutlet weak var tableView: UITableView!
    var program : Program!
    let cellIdentifier = "eventCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        registerNotifications()
        self.tableView.registerNib(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

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
        var cell : EventTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as EventTableViewCell
        
        if (cell == nil) {
            cell = EventTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        if (program.events != nil) {
            //var eventsArray: NSArray = program.events.allObjects
            var eventsArray: NSArray = program.getAllEvents()
            var event : Event! = eventsArray[indexPath.row] as Event
            cell.setEvent(event);
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200;
    }
}
