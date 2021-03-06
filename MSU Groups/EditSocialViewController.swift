//
//  EditSocialViewController.swift
//  MSU Groups
//
//  Created by Senan Haque on 12/6/20.
//

import UIKit
import Parse

class EditSocialViewController: UIViewController {

    @IBOutlet weak var instaTextField: UITextField!
    
    @IBOutlet weak var snapTextField: UITextField!
    
    @IBOutlet weak var twitterTextField: UITextField!
    
    @IBOutlet weak var linkedinTextField: UITextField!
    

    @IBOutlet weak var githubTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
        self.saveButton.layer.cornerRadius = 20
    }
    
    
    @IBAction func onBackButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToProfile", sender: self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func onSaveButton(_ sender: Any) {
        
        
        if let text = instaTextField.text, text.isEmpty {
           // myTextField is not empty here
            print("IG text field empty")
        } else {
           // myTextField is Empty
            let social = PFObject(className:"Social")
            
            social["type"] = "Instagram"
            social["socialUsername"] = instaTextField.text

            // Saves the new object.
            social.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                print("Success!!")
              } else {
                print("Error!!")
              }
            }
            
            let user = PFUser.current()
            
            user!.add(social, forKey: "socials")

            user!.saveInBackground { (success, error) in
                if success {
                    print("Social saved")
                } else {
                    print("Error saving social")
                }
            }
            
        }
        
        if let text = snapTextField.text, text.isEmpty {
           // myTextField is not empty here
            print("IG text field empty")
        } else {
           // myTextField is Empty
            let social = PFObject(className:"Social")
            
            social["type"] = "Snapchat"
            social["socialUsername"] = snapTextField.text

            // Saves the new object.
            social.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                print("Success!!")
              } else {
                print("Error!!")
              }
            }
            
            let user = PFUser.current()
            
            user!.add(social, forKey: "socials")

            user!.saveInBackground { (success, error) in
                if success {
                    print("Social saved")
                } else {
                    print("Error saving social")
                }
            }
            
        }
        
        
        if let text = twitterTextField.text, text.isEmpty {
           // myTextField is not empty here
            print("IG text field empty")
        } else {
           // myTextField is Empty
            let social = PFObject(className:"Social")
            
            social["type"] = "Twitter"
            social["socialUsername"] = twitterTextField.text

            // Saves the new object.
            social.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                print("Success!!")
              } else {
                print("Error!!")
              }
            }
            
            let user = PFUser.current()
            
            user!.add(social, forKey: "socials")

            user!.saveInBackground { (success, error) in
                if success {
                    print("Social saved")
                } else {
                    print("Error saving social")
                }
            }
            
        }
        
        if let text = linkedinTextField.text, text.isEmpty {
           // myTextField is not empty here
            print("IG text field empty")
        } else {
           // myTextField is Empty
            let social = PFObject(className:"Social")
            
            social["type"] = "Linkedin"
            social["socialUsername"] = linkedinTextField.text

            // Saves the new object.
            social.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                print("Success!!")
              } else {
                print("Error!!")
              }
            }
            
            let user = PFUser.current()
            
            user!.add(social, forKey: "socials")

            user!.saveInBackground { (success, error) in
                if success {
                    print("Social saved")
                } else {
                    print("Error saving social")
                }
            }
            
        }
        
        if let text = githubTextField.text, text.isEmpty {
           // myTextField is not empty here
            print("IG text field empty")
        } else {
           // myTextField is Empty
            let social = PFObject(className:"Social")
            
            social["type"] = "Github"
            social["socialUsername"] = githubTextField.text

            // Saves the new object.
            social.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                print("Success!!")
              } else {
                print("Error!!")
              }
            }
            
            let user = PFUser.current()
            
            user!.add(social, forKey: "socials")

            user!.saveInBackground { (success, error) in
                if success {
                    print("Social saved")
                } else {
                    print("Error saving social")
                }
            }
            
        }
        
        
        
        
        
        
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
