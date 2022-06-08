//
//  LaunchViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 07.02.22.
//

import UIKit

class LaunchViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "onboarding")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textLabel1: UILabel = {
        let label = UILabel()
        
        let attr1: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "SFPro-Heavy", size: 30)!
        ]
        let str1 = NSMutableAttributedString(string: "SOCIALZONE", attributes: attr1)
        let attr2: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.systemGray,
            NSAttributedString.Key.font: UIFont(name: "SFPro-Heavy", size: 30)!
        ]
        let str2 = NSAttributedString(string: ".IO", attributes: attr2)
        str1.append(str2)
        
        label.attributedText = str1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textLabel2: UILabel = {
        let label = UILabel()
        label.text  = "Plan, manage & get your collaborations with ease."
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(textLabel1)
        view.addSubview(textLabel2)
        
        let constraints = [
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageView.image!.size.width / 376 * 360),
            
            textLabel1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 36),
            textLabel1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textLabel2.topAnchor.constraint(equalTo: textLabel1.bottomAnchor, constant: 18),
            textLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
