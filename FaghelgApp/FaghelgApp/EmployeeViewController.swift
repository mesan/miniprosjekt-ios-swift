//
//  EmployeeViewController.swift
//  FaghelgApp
//
//  Created by Dag Einar Monsen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class EmployeeViewController: UITableViewController, UITableViewDataSource {

    var employees: [Person] = []
    var faghelgApi: FaghelgApi = FaghelgApi()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "employeesFetched:", name: Notifications.employeesNotificationId, object: nil)
        faghelgApi.getEmployees()
    }
    
    func employeesFetched(notification: NSNotification) {
        employees = notification.object as [Person]
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // return the number of cells needed
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    
    // create table cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create new table cell
        let cell =  UITableViewCell()
        
        let person = employees[indexPath.row]
        
        // set cell image
        cell.imageView?.image = UIImage(named: "\(person.shortName!).png")
        // set cell text
        cell.textLabel?.text = person.fullName
        // return the cell
        return cell
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
