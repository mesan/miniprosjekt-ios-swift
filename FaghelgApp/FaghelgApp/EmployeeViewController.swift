//
//  EmployeeViewController.swift
//  FaghelgApp
//
//  Created by Dag Einar Monsen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit
import BrightFutures

class EmployeeViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var employees: [Person] = []
    var faghelgApi: FaghelgApi = FaghelgApi()
    
    @IBOutlet weak var employeeList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faghelgApi.getEmployees()
            .onSuccess { employees in
                self.employees = employees
                
                // reload view
                self.tableView.reloadData()
            }.onFailure { error in
                // display error
                println("error: \(error)")
            }
        
        self.employeeList.delegate = self
        self.employeeList.dataSource = self
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
}
