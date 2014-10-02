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
    
    enum Day : Int {
        case Sunday = 1
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
        
        var description : String {
            switch(self) {
                case Sunday: return "Søndag"
                case Monday: return "Mandag"
                case Tuesday: return "Tirsdag"
                case Wednesday: return "Onsdag"
                case Thursday: return "Torsdag"
                case Friday: return "Fredag"
                case Saturday: return "Lørdag"
            }
        }
    }
    
    var faghelgApi: FaghelgApi = FaghelgApi()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayFilter: UISegmentedControl!
    
    var allEvents: [Event] = []
    var filteredEvents : [Event] = []
    var eventDates: [NSDate] = []
    let cellIdentifier = "eventCell"
    
    var selectedIndexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        //self.tableView.registerNib(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

        faghelgApi.getProgram()
            .onSuccess { program in
                self.allEvents = program!.events.allObjects as [Event]
                self.allEvents.sort { (event1, event2) -> Bool in
                    return event1.start.compare(event2.start) == NSComparisonResult.OrderedAscending
                }
                
                let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                
                self.eventDates = []
                for event in self.allEvents {
                    let dateComponents = calendar.components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear, fromDate: event.start)
                    let date = calendar.dateFromComponents(dateComponents)!
                    
                    if (!contains(self.eventDates, date)) {
                        self.eventDates.append(date)
                    }
                }
                
                let today = self.currentDayOfWeek()
                dispatch_async(dispatch_get_main_queue(), {
                    self.setupDayFilter(today)
                    self.filterEvents()
                    self.tableView.reloadData()
                    
                    self.scrollToCurrentEvent()
                })
            }.onFailure { error in
                println("error: \(error)")
            }
    }
    
    func setupDayFilter(selectedDay: Day) {
        self.dayFilter.removeAllSegments()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        var selectedIndex = 0
        for (var i = 0; i < eventDates.count; i++) {
            let day = calendar.component(NSCalendarUnit.CalendarUnitWeekday, fromDate: eventDates[i])
            self.dayFilter.insertSegmentWithTitle(Day.fromRaw(day)!.description, atIndex: i, animated: false)
            
            if (day == selectedDay.toRaw()) {
                selectedIndex = i
            }
        }
        
        self.dayFilter.selectedSegmentIndex = selectedIndex
    }
    
    func currentDayOfWeek() -> Day {
        let today = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let day = calendar.component(NSCalendarUnit.CalendarUnitWeekday, fromDate: today)
        
        return Day.fromRaw(day)!
    }
    
    func scrollToCurrentEvent() {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let currentHour = calendar.component(NSCalendarUnit.CalendarUnitHour, fromDate: NSDate())
        
        var currentEventIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        for (index, event: Event) in enumerate(self.filteredEvents) {
            let eventHour = calendar.component(NSCalendarUnit.CalendarUnitHour, fromDate: event.start)
            
            if (currentHour == eventHour) {
                currentEventIndexPath = NSIndexPath(forRow: index, inSection: 0)
            }
        }
        
        self.tableView.scrollToRowAtIndexPath(currentEventIndexPath, atScrollPosition:UITableViewScrollPosition.Top, animated: true)
    }
    
    @IBAction func filter(sender: UISegmentedControl) {
        self.filterEvents()
        self.tableView.reloadData()
    }
    
    func filterEvents() {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let date = eventDates[dayFilter.selectedSegmentIndex]
        
        filteredEvents = allEvents.filter() { (event: Event) -> Bool in
            return calendar.compareDate(date, toDate: event.start, toUnitGranularity: NSCalendarUnit.CalendarUnitDay) == NSComparisonResult.OrderedSame
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : EventTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as EventTableViewCell
        
        var event : Event! = filteredEvents[indexPath.row] as Event
        cell.setEvent(event);
        
        if (self.selectedIndexPath != nil && self.selectedIndexPath!.row == indexPath.row) {
            cell.extraInfoView.hidden = false
        } else {
            cell.extraInfoView.hidden = true;
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (self.selectedIndexPath != nil && self.selectedIndexPath!.row == indexPath.row) {
            return 200
        }
        
        return 70
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
