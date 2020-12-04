//
//  SocialViewCell.swift
//  MSU Groups
//
//  Created by Zach Arnold on 12/3/20.
//

import UIKit

class SocialViewCell: UITableViewCell {
    @IBOutlet weak var socialImage: UIView!
    
    @IBOutlet weak var linkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
