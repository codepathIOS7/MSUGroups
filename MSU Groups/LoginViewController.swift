//
//  LoginViewController.swift
//  MSU Groups
//
//  Created by John Lin on 11/27/20.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
        self.signInButton.layer.cornerRadius = 20
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
        
    @IBAction func onSignIn(_ sender: Any) {
        let username = emailField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user !=   nil {
                self.performSegue(withIdentifier: "signinSegue", sender: nil)
            }else{
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func inSignup(_ sender: Any) {

        self.performSegue(withIdentifier: "loginSegue", sender: nil)

    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
