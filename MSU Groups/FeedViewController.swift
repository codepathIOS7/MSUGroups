//
//  FeedViewController.swift
//  MSU Groups
//
//  Created by John Lin on 11/27/20.
//

import UIKit
import Parse
class FeedViewController: UIViewController {

    @IBOutlet weak var firstnameField: UITextField!
    
    @IBOutlet weak var lastnameField: UITextField!
    
    @IBOutlet weak var yearField: UITextField!
    
    @IBOutlet weak var majorField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func CreateAccountButton(_ sender: Any) {
        
        
        
        let userInfo = PFObject(className:"userInfo")
        userInfo["userfname"] = firstnameField.text!
        userInfo["userlname"] = lastnameField.text!
        userInfo["major"] = majorField.text!
        userInfo["year"] = yearField.text!
        
        userInfo["author"] = PFUser.current()!
        

        userInfo.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
            print("saved")
          } else {
            print("error")
            // There was a problem, check error.description
          }
        }
    }
    
}
