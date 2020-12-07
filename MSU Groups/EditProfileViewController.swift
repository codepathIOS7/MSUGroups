//
//  EditProfileViewController.swift
//  MSU Groups
//
//  Created by John Lin on 12/7/20.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController {

    @IBOutlet weak var majorTextField: UITextField!
    
    @IBOutlet weak var yearTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSaveChanges(_ sender: Any) {
        let user = PFUser.current
        user()!["major"] = majorTextField.text
        user()!["year"] = yearTextField.text
    
        user()!.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            print("Success!!")
          } else {
            print("Error!!")
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
