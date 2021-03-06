//
//  SetAlarmClockViewController.swift
//  GroupAlarm
//
//  Created by Justin Matsnev on 7/20/15.
//  Copyright (c) 2015 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts


struct alarmLabelDate {
    let alarmLabel : String
    let alarmDate : NSDate
}

class SetAlarmViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet var myDatePicker : UIDatePicker!
    var strDate : String!
   // var currentUser = PFUser.currentUser()
    let query = PFObject(className: "Alarm")
    var alarmTextLabel : String!
    var dateFormatter = NSDateFormatter()
    @IBOutlet var alarmLabelTextField : UITextField!
    @IBOutlet var saveButton : UIBarButtonItem!
    @IBAction func dateAction(sender : AnyObject) {
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmLabelTextField.delegate = self
        let date : NSDate = NSDate()
        textFieldShouldReturn(alarmLabelTextField)
        myDatePicker.minimumDate = date
        Mixpanel.sharedInstance().track("User made it to set alarm")
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
  
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
      //  saveButton.enabled = true
        alarmTextLabel = alarmLabelTextField?.text
        if alarmLabelTextField.text == "" {
            saveButton.enabled = false
        }
        else {
            saveButton.enabled = true
            Mixpanel.sharedInstance().track("User got far enough to enable save button")
        }
        return true
    }
    
    
    
    
    @IBAction func addButton(sender : AnyObject) {
        strDate = dateFormatter.stringFromDate(myDatePicker.date)

        let myAlarm =  dateFormatter.dateFromString(strDate)!
        //println(strDate)
        let destinationVC = PickFriendsViewController()
        destinationVC.alarmVar = alarmLabelDate(alarmLabel: alarmTextLabel, alarmDate: myAlarm)

        // Let's assume that the segue name is called playerSegue
        // This will perform the segue and pre-load the variable for you to use
        
//        self.performSegueWithIdentifier("alarmToFriend", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "alarmToFriend" {
            let myAlarm =  dateFormatter.dateFromString(strDate)!
            
            let newVarAlarm = alarmLabelDate(alarmLabel: alarmTextLabel, alarmDate: myAlarm)
            
            // Create a new variable to store the instance of PlayerTableViewController
            let destinationVC = segue.destinationViewController as! PickFriendsViewController
            destinationVC.alarmVar = newVarAlarm
        }
    
    
}
  
    
    
}