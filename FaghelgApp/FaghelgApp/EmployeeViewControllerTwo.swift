//
//  EmployeeViewControllerTwo.swift
//  FaghelgApp
//
//  Created by Patrick Romstad on 22/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

//
//  EmployeeViewController.swift
//  FaghelgApp
//
//  Created by Dag Einar Monsen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit
import BrightFutures

class EmployeeViewControllerTwo: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var employees: [Person] = []
    var faghelgApi: FaghelgApi = FaghelgApi()


    @IBOutlet weak var employeeList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        faghelgApi.getEmployees()
            .onSuccess { employees in
                self.employees = employees

                // reload view using main thread 
                NSOperationQueue.mainQueue().addOperationWithBlock(){
                    self.employeeList.reloadData()
                }
            }.onFailure { error in
                // display error
                println("error: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }

    // return the number of cells needed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }

    // create table cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get cell from tableView
        let employeeCell: EmployeeCell = tableView.dequeueReusableCellWithIdentifier("Cell") as EmployeeCell

        let person = employees[indexPath.row]

        employeeCell.setCell(person.fullName!, shortName: person.shortName!)

        // return the cell
        return employeeCell
    }
}
