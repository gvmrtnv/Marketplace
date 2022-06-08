//
//  InvoiceShadowTextView.swift
//  Influencer
//
//  Created by Gleb Martynov on 02.03.22.
//

import UIKit

class InvoiceShadowTextView: UIView {

    public lazy var titleLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "title"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()

    public lazy var textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.layer.cornerRadius = 14
        view.backgroundColor = .white
//        textField.text = "Placeholder"
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.borderWidth = 1
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = .no
//        textField.autocapitalizationType = .none
        return view
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
        addSubview(textView)
 
        
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 104),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shadowView.topAnchor.constraint(equalTo: textView.topAnchor),
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
