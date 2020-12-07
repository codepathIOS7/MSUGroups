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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
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
        
        nameLabel.text = fullName
        
        yearLabel.text = PFUser.current()?["year"] as? String
        majorLabel.text = PFUser.current()?["major"] as? String
        
        self.tableView.reloadData()
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        self.performSegue( withIdentifier: "unwindToLogin", sender: nil)
        
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
        return socials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialViewCell") as! SocialViewCell
        
        let socials = (PFUser.current()?["socials"] as? [PFObject]) ?? []
        let social = socials[indexPath.row]
        let id = social.objectId!
        
        // Find social media account within database
        let query = PFQuery(className:"Social")
        query.getObjectInBackground(withId: id) { (socialGot, error) in
            if error == nil {
                cell.linkLabel.text = (socialGot?["socialUsername"] as! String)
                // Get image from type of social media
                let type = socialGot?["type"] as! String
                let imageString = cell.getSocialImage(socialName: type)
                let image = UIImage(named: imageString)
                cell.socialLogo.image = image

            } else {
                print("Error retrieving social account")
            }
        }
        
        return cell
    }
    

    
}
