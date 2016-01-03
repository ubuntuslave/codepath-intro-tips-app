//
//  ViewController.swift
//  tips
//
//  Created by Carlos Jaramillo on 12/30/15.
//  Copyright © 2015 Carlos Jaramillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var total_label: UILabel!
    @IBOutlet weak var bill_field: UITextField!
    @IBOutlet weak var tip_label: UILabel!
    @IBOutlet weak var tip_control: UISegmentedControl!
    @IBOutlet weak var divider_view: UIView!
    @IBOutlet var main_view: UIView!
    let timeout_threshold = 10 * 60.0 // 10 minutes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tip_label.text = "$0.00"
        total_label.text = "$0.00"
        self.title = "Tip Calculator"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // print("view will appear")
        // This is a good place to retrieve the default tip percentage from NSUserDefaults
        // and use it to update the tip amount
        let defaults = NSUserDefaults.standardUserDefaults()
        tip_control.selectedSegmentIndex = defaults.integerForKey("default_tip_percentage")
        
        // Check last date to be less than
        // let last_recorded_date: NSDate = defaults.objectForKey("last_date")
        let last_recorded_ref_seconds = defaults.doubleForKey("last_date_seconds")
        let current_ref_seconds = NSDate.timeIntervalSinceReferenceDate()
        let time_interval = current_ref_seconds - last_recorded_ref_seconds
        //print("TIME passed \(time_interval): \(current_ref_seconds) - \(last_recorded_ref_seconds)")
        if time_interval < timeout_threshold{
            // Load last bill amount
            bill_field.text = String(defaults.doubleForKey("last_bill_amount"))
        }
        else{
            bill_field.text = ""
            tip_label.text = "$0.00"
            total_label.text = "$0.00"
        }
        
        // Set focus to the text field.
        bill_field.becomeFirstResponder()

        // Animations:
        self.main_view.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0xFF / 0xFF)
        self.divider_view.alpha = 0
        UIView.animateWithDuration(1.2, animations: {
            // This causes first view to fade in and second view to fade out
            self.divider_view.alpha = 1
            //self.main_view.backgroundColor = UIColor.purpleColor()
            self.main_view.backgroundColor = UIColor(colorLiteralRed: 0.7, green: 0.0, blue: 0.9, alpha: 0xFF / 0xFF)
        })
        
        self.on_editing_changed(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        //print("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func on_editing_changed(sender: AnyObject) {
        let tip_percentages = [0.18, 0.2, 0.22]
        let tip_percentage = tip_percentages[tip_control.selectedSegmentIndex]
        
        // Saving last index used as default tip percentage
        //let defaults = NSUserDefaults.standardUserDefaults()
        //defaults.setInteger(tip_control.selectedSegmentIndex, forKey: "default_tip_percentage")
        //defaults.synchronize()
        
        if bill_field.text!.isEmpty == false
        {
            let bill_amount =  Double(bill_field.text!)
            
            let tip = bill_amount! * tip_percentage
            let total = bill_amount! + tip
            
            // Saving last bill amount
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setDouble(bill_amount!, forKey: "last_bill_amount")
            // Save last date
//            defaults.setObject(NSDate(), forKey: "last_date")
            defaults.setDouble(NSDate.timeIntervalSinceReferenceDate(), forKey: "last_date_seconds")

            defaults.synchronize()
            
            tip_label.text = String(format: "$%.2f", tip)
            total_label.text = String(format: "$%.2f", total)
        }
    }

    @IBAction func on_tap(sender: AnyObject) {
        view.endEditing(true)
    }
    

}

