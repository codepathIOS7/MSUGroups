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

        // Do any additional setup after loading the view.
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
