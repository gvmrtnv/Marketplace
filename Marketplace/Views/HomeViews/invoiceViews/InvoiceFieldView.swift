//
//  InvoiceFieldView.swift
//  Influencer
//
//  Created by Gleb Martynov on 28.02.22.
//

import UIKit

class InvoiceFieldView: UIView {

    public lazy var titleLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "title"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()

    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.layer.cornerRadius = 14
        textField.backgroundColor = .white
//        textField.text = "Placeholder"
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.borderWidth = 1
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
//        textField.autocapitalizationType = .none
        return textField
    }()
    
    public lazy var shadowView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        layer.cornerRadius = 14
        
        return view
    }()
    
    
    init() {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
      
        layer.cornerRadius = 14
        
        addSubview(shadowView)
        addSubview(titleLabel)
        addSubview(textField)
 
        
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 56),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shadowView.topAnchor.constraint(equalTo: textField.topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor)
          
            ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            

}
