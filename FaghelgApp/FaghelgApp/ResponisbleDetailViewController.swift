//
//  ResponisbleDetailViewController.swift
//  FaghelgApp
//
//  Created by Lars Kristian Nymoen on 16/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit
import CoreData

class ResponisbleDetailViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    @IBOutlet var txtId: UITextField!
    @IBOutlet var txtShortName: UITextField!
    @IBOutlet var txtFullName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(sender: AnyObject) {
        createPerson()
        dismissViewController()
    }
    
    @IBAction func cancel(sender: AnyObject){
        dismissViewController();
    }
    
    func dismissViewController(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func createPerson(){
        let entityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedObjectContext!)
        let resp = Person(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        resp.id = txtId.text
        resp.shortName = txtShortName.text
        resp.fullName = txtFullName.text
        
        managedObjectContext?.save(nil)
        
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
