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

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var reEnterField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var backToSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
        self.signUpButton.layer.cornerRadius = 20
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func backToSignIn(_ sender: Any) {
        self.performSegue( withIdentifier: "unwindToLogin", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    @IBAction func showAlert(_ sender: Any, message: String) {
        let alertController = UIAlertController(title: "Sign Up Error", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func AllFieldsFilled() -> Bool {
        return firstnameField.text != "" &&
        lastnameField.text != "" &&
        emailField.text != "" &&
        passwordField.text != "" &&
        reEnterField.text != ""
    }
    
    
    func ValidateFields() -> Bool {
        let email = emailField.text!
        if !AllFieldsFilled() {
            showAlert(self, message: "One or more text fields empty.")
        }
        else if !isValidEmail(email) {
            showAlert(self, message: "Email not valid.")
        }
        else if passwordField.text != reEnterField.text {
            showAlert(self, message: "Passwords do not match.")
        }
        else {
            return true
        }
        return false
    }
    
    
    @IBAction func CreateAccountButton(_ sender: Any) {
        
        if ValidateFields() {
            
            let user = PFUser()
            user.email = emailField.text
            user.username = emailField.text
            user.password = passwordField.text
            user["firstName"] = firstnameField.text
            user["lastName"] = lastnameField.text
            
            //user.add(social, forKey: "socials")

//            user.saveInBackground { (success, error) in
//                if success {
//                    print("Social saved")
//                } else {
//                    print("Error saving social")
//                }
//            }
            
//            if var userSocials = user["socials"] as? [PFObject] {
//                userSocials.append(social)
//                social["socials"] = userSocials
//                print("Done!!!")
//            }
            
            
            

            user.signUpInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                // The object has been saved.
                print("saved")
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
              } else {
                print("error")
                // There was a problem, check error.description
              }
            }
        }
    }
    
}
