//
//  ProgramViewController.swift
//  FaghelgApp
//
//  Created by Anders Ullnæss on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import Foundation
import UIKit
import BrightFutures

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var faghelgApi: FaghelgApi = FaghelgApi()
    
    @IBOutlet weak var tableView: UITableView!
    var program : Program!
    let cellIdentifier = "eventCell"
    
    var selectedIndexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.tableView.registerNib(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        faghelgApi.getProgram()
            .onSuccess { program in
                self.program = program;
                self.tableView.reloadData()
                
                self.scrollToActualEvent()
                //Vi ønsker å scrolle når appen åpnes og første viewet som dukker opp er ProgramViewet.
                //Må også håndtere at brukeren kan trykke på home knappen, åpne knappen og få appen til å scrolle til aktuelle da også.
            }.onFailure { error in
                println("error: \(error)")
            }
    }
    
    func scrollToActualEvent() {
        if (self.program != nil) {
            var eventer: NSArray = self.program.events.allObjects
            var indexForActualEvent = self.program.getIndexForActualEvent()
            var indexPath = NSIndexPath(forRow: indexForActualEvent, inSection: 0)
            self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition:UITableViewScrollPosition.Top, animated: true)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (program != nil) {
            return program.numberOfEvents!
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : EventTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as EventTableViewCell
        
        if (program.events != nil) {
            var eventsArray: NSArray = program.getAllEvents()
            var event : Event! = eventsArray[indexPath.row] as Event
            cell.setEvent(event);
            
            if (self.selectedIndexPath != nil && self.selectedIndexPath!.row == indexPath.row) {
                cell.extraInfoView.hidden = false
            } else {
                cell.extraInfoView.hidden = true;
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (self.selectedIndexPath != nil && self.selectedIndexPath!.row == indexPath.row) {
            return 160
        }
        
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var previousIndexPath : NSIndexPath?
        
        if (self.selectedIndexPath == nil) {
            self.selectedIndexPath = indexPath
        } else if (self.selectedIndexPath?.row == indexPath.row) {
            self.selectedIndexPath = nil
        } else {
            previousIndexPath = self.selectedIndexPath
            self.selectedIndexPath = indexPath
        }
        
        var indexPaths = [NSIndexPath]()
        indexPaths.append(indexPath);
        if (previousIndexPath != nil) {
            indexPaths.append(previousIndexPath!)
        }
        
        self.tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
    }
}
