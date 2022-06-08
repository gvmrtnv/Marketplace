//
//  BackgroundGradientView.swift
//  Influencer
//
//  Created by Gleb Martynov on 09.02.22.
//

import UIKit

class BackgroundGradientView: UIView {

    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,

            UIColor(red: 0.983, green: 0.993, blue: 0.996, alpha: 1).cgColor,

            UIColor(red: 0.983, green: 0.996, blue: 1, alpha: 1).cgColor
          ]
        
        gradient.locations = [0, 0.57, 0.98]

        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)

        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)

        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.1, b: 0.09, c: -0.24, d: 0.11, tx: 0.12, ty: 0.07))
        return gradient
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.addSublayer(gradient)

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
