//
//  SettingsViewController.swift
//  tips
//
//  Created by Carlos Jaramillo on 1/3/16.
//  Copyright © 2016 Carlos Jaramillo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tip_control: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Retrieve the current default tip percentage from NSUserDefaults
            let defaults = NSUserDefaults.standardUserDefaults()
            self.tip_control.selectedSegmentIndex = defaults.integerForKey("default_tip_percentage")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tip_default_changed(sender: AnyObject) {
        // Saving last index used as default tip percentage
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tip_control.selectedSegmentIndex, forKey: "default_tip_percentage")
        defaults.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
