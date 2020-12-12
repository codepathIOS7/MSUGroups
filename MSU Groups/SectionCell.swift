//
//  SectionCell.swift
//  MSU Groups
//
//  Created by Zach Arnold on 12/12/20.
//

import UIKit

class SectionCell: UITableViewCell {

    @IBOutlet weak var section: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
