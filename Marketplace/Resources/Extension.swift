//
//  Extension.swift
//  Influencer
//
//  Created by Gleb Martynov on 17.01.22.
//

import UIKit

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}

extension SceneDelegate {
    func changeRootViewController(_ vc: UIViewController, animated: Bool  = true) {
        guard let window = self.window else {return}
        window.rootViewController = vc
        
    }
    
}

// MARK: - Colours

extension UIColor {
    class func lightBlue() -> UIColor{
        return UIColor(red: 0.835, green: 0.922, blue: 0.953, alpha: 1)
    }
}

extension String {

    // formatting text for currency textField
    func currencyInputFormatting() -> String {
    
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2

        var amountWithPrefix = self
    
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
    
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double/100))
    
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
    
        return formatter.string(from: number)!
    }
    // formatting text for tax% textField
    func percentInputFormatting() -> String {
    
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
//        formatter.currencySymbol = "$"
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2

        var amountWithPrefix = self
    
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "%", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
    
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double/100))
    
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
    
        return formatter.string(from: number)!
    }
    
}

extension UIView {
    func generateShadow() {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = .zero
    }
    
}




class ShadowView: UIView {
    override var bounds: CGRect {
        didSet{
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 14).cgPath
        self.layer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = .zero
    }
}

class TextShadowField: UITextField {
    override var bounds: CGRect {
        didSet{
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 14).cgPath
        self.layer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = .zero
    }
}

class ShadowDatePicker: UIDatePicker {
    override var bounds: CGRect {
        didSet{
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 14).cgPath
        self.layer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = .zero
    }
}

