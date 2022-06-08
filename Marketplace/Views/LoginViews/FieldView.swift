//
//  FieldView.swift
//  Influencer
//
//  Created by Gleb Martynov on 08.02.22.
//

import UIKit

class UIShowHideTextField: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
            return CGRect(x: bounds.width - 70, y: bounds.midY-8, width: 50, height: 16)
        }
}

class FieldView: UIView {
    
    public lazy var icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    public lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        return view
    }()
    
    public lazy var textField: UIShowHideTextField = {
        let textField = UIShowHideTextField()
        textField.font = .systemFont(ofSize: 16)
        
        textField.layer.maskedCorners = [
            .layerMaxXMaxYCorner,
            .layerMaxXMinYCorner
        ]
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    
    init() {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
      
        layer.cornerRadius = 14

        
        addSubview(textField)
        addSubview(icon)
        addSubview(separatorView)
        
        
        let constraints = [
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor, constant: 8),
            
            icon.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            separatorView.widthAnchor.constraint(equalToConstant: 1)
            
            ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
//    func generateShadow() {
////        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 14).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale
//        layer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
//        layer.shadowOpacity = 1
//        layer.shadowRadius = 10
//        layer.shadowOffset = .zero
//    }

}
