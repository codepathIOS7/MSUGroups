//
//  ProfileViewController.swift
//  MSU Groups
//
//  Created by John Lin on 11/28/20.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var socials = [PFObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.tableView.reloadData()
        
        
        // Do any additional setup after loading the view.
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
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let file = PFUser.current()?["profileImage"] as? PFFileObject
        
        file?.getDataInBackground { (imageData: Data?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let imageData = imageData {
                let image = UIImage(data: imageData)
                self.profileImage.image = image
            }
        }
        
        let firstName = PFUser.current()?["firstName"] as! String
        let lastName = PFUser.current()?["lastName"] as! String
        let fullName = firstName + " " + lastName
        
        self.nameLabel.text = fullName
        
        self.yearLabel.text = PFUser.current()?["year"] as? String
        self.majorLabel.text = PFUser.current()?["major"] as? String
        let user = PFUser.current()! as PFObject
        print(user["year"] as! String)
        self.socials = (user["socials"] as? [PFObject]) ?? []
        
        
        
        
        self.tableView.reloadData()
    }

    @IBAction func onLogoutButton(_ sender: Any) {
//        // Temporary - delete later
//        let social = PFObject(className:"Social")
//
//        social["type"] = "Snapchat"
//        social["socialUsername"] = "colearnold04"
//        social["owner"] = PFUser.current()
//
//        // Saves the new object.
//        social.saveInBackground {
//          (success: Bool, error: Error?) in
//          if (success) {
//            print("Success!!")
//          } else {
//            print("Error!!")
//          }
//        }
//
//        PFUser.current()?.add(social, forKey: "socials")
//
//        PFUser.current()?.saveInBackground { (success, error) in
//            if success {
//                print("Social saved")
//            } else {
//                print("Error saving social")
//            }
//        }
        
        PFUser.logOut()
        
        self.performSegue( withIdentifier: "unwindToLogin", sender: nil)
        
 
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.socials.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialViewCell") as! SocialViewCell
        
        self.socials[indexPath.row].fetchIfNeededInBackground { (social, error) in
            if social != nil {
                cell.linkLabel.text = (social?["socialUsername"] as! String)
                let socialType = social?["type"] as! String
                cell.socialLogo.image = self.getSocialImage(socialName: socialType)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        
        return cell
    }
    
    
    // Using social media type, return string of image name
    func getSocialImage(socialName: String) -> UIImage {
        // Instagram currently not supported, add in another commit
        var imageString : String
        switch socialName {
        case "Snapchat":
            imageString = "Ghost Logo - Primary.png"
        case "Linkedin":
            imageString = "LI-In-Bug.png"
        case "Twitter":
            imageString = "Twitter_Logo_Blue.png"
        case "Facebook":
            imageString = "f_logo_RGB-Blue_250.png"
        case "Github":
            imageString = "GitHub-Mark-120px-plus.png"
        default:
            imageString = "msulogo.png"
        }
        let image = UIImage(named: imageString)
        return image!
    }

    
    
}
