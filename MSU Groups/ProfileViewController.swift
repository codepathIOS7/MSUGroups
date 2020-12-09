//
//  ProfileViewController.swift
//  MSU Groups
//
//  Created by John Lin on 11/28/20.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var socialType : String = ""
    var AddingSocial = false
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    let socialList = ["Snapchat", "Linkedin", "Twitter", "Instagram", "Github", "Facebook"]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var majorLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
//        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      
          // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
//        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//           // if keyboard size is not available for some reason, dont do anything
//           return
//        }
//
//      // move the root view up by the distance of keyboard height
//      self.view.frame.origin.y = 0 - keyboardSize.height
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//      // move back the root view origin to zero
//      self.view.frame.origin.y = 0
//    }
    
    
    
    
    
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
        
        nameLabel.text = fullName
        
        yearLabel.text = PFUser.current()?["year"] as? String
        majorLabel.text = PFUser.current()?["major"] as? String
        
        self.tableView.reloadData()
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        self.performSegue( withIdentifier: "unwindToLogin", sender: nil)
        
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        
//        let main = UIStoryboard(name: "Main", bundle: nil)
//        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
//
//        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
//
//        sceneDelegate.window?.rootViewController = loginViewController
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let socials = (PFUser.current()?["socials"] as? [PFObject]) ?? []
        if self.AddingSocial {
            return socials.count + 1
        }
        return socials.count
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let socials = (PFUser.current()?["socials"] as? [PFObject]) ?? []
        
        if indexPath.row < socials.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialViewCell") as! SocialViewCell
            
            let social = socials[indexPath.row]
            let id = social.objectId!
            
            // Find social media account within database
            let query = PFQuery(className:"Social")
            query.getObjectInBackground(withId: id) { (socialGot, error) in
                if error == nil {
                    cell.linkLabel.text = (socialGot?["socialUsername"] as! String)
                    // Get image from type of social media
                    let type = socialGot?["type"] as! String
                    let image = self.getSocialImage(socialName: type)
                    cell.socialLogo.image = image

                } else {
                    print("Error retrieving social account")
                }
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddSocialCell")!
            
            return cell
        }
        
        
    }
    

    @IBAction func onAddSocial(_ sender: Any) {
        self.AddingSocial = true
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
                

        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
        self.tableView.reloadData()
    }
    
    @objc func onDoneButtonTapped() {

        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return socialList.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return socialList[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.socialType = socialList[row]
    }
    
}
