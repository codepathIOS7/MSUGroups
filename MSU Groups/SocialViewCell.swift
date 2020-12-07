//
//  SocialViewCell.swift
//  MSU Groups
//
//  Created by Zach Arnold on 12/3/20.
//

import UIKit

class SocialViewCell: UITableViewCell {
    
    @IBOutlet weak var socialLogo: UIImageView!
    @IBOutlet weak var linkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Using social media type, return string of image name
    func getSocialImage(socialName: String) -> String {
        // Instagram currently not supported, add in another commit
        switch socialName {
        case "Snapchat":
            return "Ghost Logo - Primary.png"
        case "Linkedin":
            return "LI-In-Bug.png"
        case "Twitter":
            return "Twitter_Logo_Blue.png"
        case "Facebook":
            return "f_logo_RGB-Blue_250.png"
        case "Github":
            return "GitHub-Mark-120px-plus.png"
        default:
            return "msulogo.png"
        }
    }

}
