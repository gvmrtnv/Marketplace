//
//  ChatTableViewCell.swift
//  Influencer
//
//  Created by Gleb Martynov on 30.01.22.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var fullName: UILabel!
    @IBOutlet var lastMessage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
