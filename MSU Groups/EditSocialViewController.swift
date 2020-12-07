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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
