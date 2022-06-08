//
//  PersonTableViewCell.swift
//  Influencer
//
//  Created by Gleb Martynov on 23.01.22.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var fullName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
