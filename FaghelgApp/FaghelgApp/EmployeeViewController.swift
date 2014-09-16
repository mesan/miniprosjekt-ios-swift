//
//  EmployeeViewController.swift
//  FaghelgApp
//
//  Created by Dag Einar Monsen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class EmployeeViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var employees: [Person] = []
    var faghelgApi: FaghelgApi = FaghelgApi()
    
    @IBOutlet weak var employeeList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "employeesFetched:", name: Notifications.employeesNotificationId, object: nil)
        faghelgApi.getEmployees()
        
        self.employeeList.delegate = self
        self.employeeList.dataSource = self
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
        // get cell from tableView
        let employeeCell: EmployeeCell = tableView.dequeueReusableCellWithIdentifier("Cell") as EmployeeCell

        let person = employees[indexPath.row]
        
        employeeCell.setCell(person.fullName!, shortName: person.shortName!)
        
        // return the cell
        return employeeCell 
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
