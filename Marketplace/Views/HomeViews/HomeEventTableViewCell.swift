//
//  HomeMenuTableViewCell.swift
//  Influencer
//
//  Created by Gleb Martynov on 20.02.22.
//

import UIKit

class HomeEventTableViewCell: UITableViewCell {
    
    
    
    private lazy var backView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.backgroundColor = .white
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 1
        
        
        return view
    }()
    
    private lazy var grayPunkt: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.94, green: 0.95, blue: 0.95, alpha: 0.71)
        view.layer.cornerRadius = 9.5
        return view
        
    }()
    
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.text = "Placeholder"
        return label
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "Placeholder"
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(red: 0.88, green: 0.95, blue: 0.99, alpha: 1.00)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(backView)
        contentView.addSubview(grayPunkt)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        
        
        let constraints = [
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            
            grayPunkt.topAnchor.constraint(equalTo: backView.topAnchor, constant: 23),
            grayPunkt.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 23),
            grayPunkt.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -22),
            grayPunkt.heightAnchor.constraint(equalToConstant: 19),
            grayPunkt.widthAnchor.constraint(equalTo: grayPunkt.heightAnchor),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: grayPunkt.trailingAnchor, constant: 14),
            titleLabel.centerYAnchor.constraint(equalTo: grayPunkt.centerYAnchor),
            
            dateLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            dateLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            
            
        
          
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}



