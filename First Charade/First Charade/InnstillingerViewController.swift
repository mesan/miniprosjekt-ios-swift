//
//  InstillingerViewController.swift
//  First Charade
//
//  Created by Mikkel Steine on 22/09/14.
//  Copyright (c) 2014 Mesan. All rights reserved.
//

import UIKit

class InnstillingerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var rundetid: UIPickerView!
    @IBOutlet weak var ordbok: UIPickerView!

    var spill: Spill!
    var rundetider: NSArray = []
    var ordbøker: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.spill = appDelegate.spill
        
        rundetider = spill.rundetider
        ordbøker = spill.ordbøker
        
        rundetid.selectRow(rundetider.indexOfObject(spill.rundetid), inComponent: 0, animated: true)
        ordbok.selectRow(ordbøker.indexOfObject(spill.ordbokNavn()), inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
*/
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == rundetid) {
            return rundetider.count
        } else {
            return ordbøker.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (pickerView == rundetid) {
            return "\(rundetider[row])"
        } else {
            return "\(ordbøker[row])"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == rundetid) {
            spill.rundetid = rundetider[row] as NSNumber
        } else if (pickerView == ordbok) {
            spill.ordbok = row
        }
    }
}