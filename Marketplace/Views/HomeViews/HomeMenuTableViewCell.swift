//
//  HomeMenuTableViewCell.swift
//  Influencer
//
//  Created by Gleb Martynov on 20.02.22.
//

import UIKit

class HomeMenuTableViewCell: UITableViewCell {
    
    
    
    private lazy var backView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.backgroundColor = .white
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 1
        
        
        return view
    }()
    
    private lazy var folderImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "folder")
        return view
        
    }()
    
    private lazy var arrow: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "arrow")
        return view
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.text = "Placeholder"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        backgroundColor = .white
        contentView.addSubview(backView)
        contentView.addSubview(folderImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrow)
        
        var constraints = [
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            
            folderImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 12),
            folderImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            folderImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -12),
            
            folderImage.widthAnchor.constraint(equalTo: folderImage.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: folderImage.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: folderImage.centerYAnchor),
            
            arrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            arrow.centerYAnchor.constraint(equalTo: folderImage.centerYAnchor),
            arrow.heightAnchor.constraint(equalToConstant: 24),
            arrow.widthAnchor.constraint(equalTo: arrow.heightAnchor)
        ]
        let folderHeightConstraint = folderImage.heightAnchor.constraint(equalToConstant: 40)
//        folderHeightConstraint.priority = UILayoutPriority(999)
        constraints.append(folderHeightConstraint)
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


