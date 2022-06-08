//
//  ValueTableViewCell.swift
//  Influencer
//
//  Created by Gleb Martynov on 27.01.22.
//

import UIKit

class ValueTableViewCell: UITableViewCell {
    @IBOutlet var cellValue: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
