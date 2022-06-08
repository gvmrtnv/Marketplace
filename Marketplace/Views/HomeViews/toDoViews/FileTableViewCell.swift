//
//  FileTableViewCell.swift
//  Influencer
//
//  Created by Gleb Martynov on 27.02.22.
//

import UIKit

class FileTableViewCell: UITableViewCell {
    
    private lazy var backView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.backgroundColor = .white
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 1
        
        
        return view
    }()
    
    public lazy var fileImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "fileInvoice")
        return view
        
    }()
    
   
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "Placeholder"
        
        return label
    }()
    
    public lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.text = "Placeholder"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.addSubview(backView)
        contentView.addSubview(fileImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(weightLabel)
        
        
        let constraints = [
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            
            fileImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            fileImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            fileImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            fileImage.heightAnchor.constraint(equalToConstant: 44),
            fileImage.widthAnchor.constraint(equalToConstant: 45),
            
            titleLabel.topAnchor.constraint(equalTo: fileImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: fileImage.trailingAnchor, constant: 16),
           
            weightLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            weightLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
            
        ]
     

        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


   

