//
//  CheckBox.swift
//  Influencer
//
//  Created by Gleb Martynov on 09.02.22.
//

import UIKit

class CheckBox: UIButton {

    init() {
        super.init(frame: CGRect())
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 0.498, green: 0.541, blue: 0.914, alpha: 1)
        layer.cornerRadius = 4
        let image = UIImage(systemName: "checkmark")
        setImage(image, for: .selected)
        tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
