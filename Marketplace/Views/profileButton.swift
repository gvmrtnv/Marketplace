//
//  profileButton.swift
//  Influencer
//
//  Created by Gleb Martynov on 17.02.22.
//

import UIKit

class ProfileButton: UIButton {
    
    // MARK: - Views
    
    public lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "emptyAvatar")
        imageView.image = image
        return imageView
    }()
    
    public lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    public lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My profile"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
   
    
    
    
    // MARK: - View init

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(profileImage)
        addSubview(helloLabel)
        addSubview(profileLabel)
        
        
        let constraints = [
            profileImage.topAnchor.constraint(equalTo: topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 48),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            
            helloLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            helloLabel.topAnchor.constraint(equalTo: topAnchor),
            helloLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            profileLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            profileLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
           
            ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
