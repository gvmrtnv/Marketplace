//
//  DateTableViewCell.swift
//  Influencer
//
//  Created by Gleb Martynov on 27.01.22.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    @IBOutlet var dateTime: UIDatePicker!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
