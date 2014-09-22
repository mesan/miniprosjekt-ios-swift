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
    var cellHidden : Bool = true
    
    var selectedIndexPath: NSIndexPath?

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
        var cell : EventTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as EventTableViewCell
        
        if (cell == nil) {
            cell = EventTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        if (program.events != nil) {
            var eventsArray: NSArray = program.events.allObjects
            var event : Event! = eventsArray[indexPath.row] as Event
            cell.setEvent(event);
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //var cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as EventTableViewCell
        
        if (self.selectedIndexPath != nil && self.selectedIndexPath!.row == indexPath.row) {
            //cell.extraInfoView.hidden = false
            return 160
        }
        
        //cell.extraInfoView.hidden = true
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = self.tableView.cellForRowAtIndexPath(indexPath) as EventTableViewCell
        if (self.selectedIndexPath == nil) {
            self.selectedIndexPath = indexPath
            cell.extraInfoView.hidden = false
        }
        else if (self.selectedIndexPath?.row == indexPath.row) {
            self.selectedIndexPath = nil
            cell.extraInfoView.hidden = false
        }
        else {
            var previousCell = self.tableView.cellForRowAtIndexPath(self.selectedIndexPath!) as EventTableViewCell
            previousCell.extraInfoView.hidden = true
            cell.extraInfoView.hidden = true

            self.tableView.reloadRowsAtIndexPaths([self.selectedIndexPath!], withRowAnimation: UITableViewRowAnimation.None)
            self.selectedIndexPath = indexPath
        }
        

        //cell.extraInfoView.hidden = !cell.extraInfoView.hidden
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
}
