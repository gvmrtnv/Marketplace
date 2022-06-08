//
//  VackgroundLayer.swift
//  Influencer
//
//  Created by Gleb Martynov on 08.02.22.
//

import Foundation
import UIKit

public class BackgroundLayer {
    
    static var gradient: CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,

            UIColor(red: 0.98, green: 0.99, blue: 1, alpha: 1).cgColor,

            UIColor(red: 0.98, green: 1, blue: 1, alpha: 1).cgColor
          ]
        
        return gradient
    }

}
