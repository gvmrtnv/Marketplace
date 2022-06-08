//
//  SocialMediaSelectorViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 26.02.22.
//

import UIKit

class SocialMediaSelectorViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Platform"
        label.font = .boldSystemFont(ofSize: 21)
        return label
    }()
    
    private lazy var instaBox: CheckBox = {
        let view = CheckBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelected = false
        view.addTarget(self, action: #selector(boxDidTapped), for: .touchUpInside)
        view.backgroundColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00)
        return view
    }()
    
    private lazy var tikBox: CheckBox = {
        let view = CheckBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(boxDidTapped), for: .touchUpInside)
        view.backgroundColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00)
        return view
    }()
    
    private lazy var youBox: CheckBox = {
        let view = CheckBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(boxDidTapped), for: .touchUpInside)
        view.backgroundColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00)
        return view
    }()
    private lazy var twitchBox: CheckBox = {
        let view = CheckBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(boxDidTapped), for: .touchUpInside)
        view.backgroundColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00)
        return view
    }()
    private lazy var onlyBox: CheckBox = {
        let view = CheckBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(boxDidTapped), for: .touchUpInside)
        view.backgroundColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00)
        return view
    }()
    
    
    private lazy var instaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Skype"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var tikLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Teams"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var youLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Zoom"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var twitchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "On-site"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var onlyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Other"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: config)
        
    
        view.setImage(image, for: .normal)
        view.tintColor = UIColor(red: 0.89, green: 0.89, blue: 0.90, alpha: 1.00)
        view.backgroundColor = UIColor(red: 0.51, green: 0.55, blue: 0.60, alpha: 1.00)
        view.layer.cornerRadius = 12
        view.addTarget(self, action: #selector(closeDidTapped(_:)), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(applyButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Values
    
    var platforms = [String]()
    weak var delegate: SocialMediaDelegate?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(instaBox)
        view.addSubview(tikBox)
        view.addSubview(youBox)
        view.addSubview(twitchBox)
        view.addSubview(onlyBox)
        view.addSubview(instaLabel)
        view.addSubview(tikLabel)
        view.addSubview(youLabel)
        view.addSubview(twitchLabel)
        view.addSubview(onlyLabel)
        view.addSubview(applyButton)
        
        if platforms.contains("Skype") {
            instaBox.isSelected = true
        }
        if platforms.contains("Teams") {
            tikBox.isSelected = true
        }
        if platforms.contains("Zoom") {
            youBox.isSelected = true
        }
        if platforms.contains("On-site") {
            twitchBox.isSelected = true
        }
        if platforms.contains("Other") {
            onlyBox.isSelected = true
        }
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 13),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 13),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            instaBox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            instaBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instaBox.widthAnchor.constraint(equalToConstant: 24),
            instaBox.heightAnchor.constraint(equalTo: instaBox.widthAnchor),
            
            tikBox.topAnchor.constraint(equalTo: instaBox.bottomAnchor, constant: 16),
            tikBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tikBox.widthAnchor.constraint(equalToConstant: 24),
            tikBox.heightAnchor.constraint(equalTo: tikBox.widthAnchor),
            
            youBox.topAnchor.constraint(equalTo: tikBox.bottomAnchor, constant: 16),
            youBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            youBox.widthAnchor.constraint(equalToConstant: 24),
            youBox.heightAnchor.constraint(equalTo: youBox.widthAnchor),
            
            twitchBox.topAnchor.constraint(equalTo: youBox.bottomAnchor, constant: 16),
            twitchBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            twitchBox.widthAnchor.constraint(equalToConstant: 24),
            twitchBox.heightAnchor.constraint(equalTo: twitchBox.widthAnchor),
            
            onlyBox.topAnchor.constraint(equalTo: twitchBox.bottomAnchor, constant: 16),
            onlyBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            onlyBox.widthAnchor.constraint(equalToConstant: 24),
            onlyBox.heightAnchor.constraint(equalTo: onlyBox.widthAnchor),
            
            instaLabel.leadingAnchor.constraint(equalTo: instaBox.trailingAnchor, constant: 8),
            instaLabel.centerYAnchor.constraint(equalTo: instaBox.centerYAnchor),
            
            tikLabel.leadingAnchor.constraint(equalTo: tikBox.trailingAnchor, constant: 8),
            tikLabel.centerYAnchor.constraint(equalTo: tikBox.centerYAnchor),
            
            youLabel.leadingAnchor.constraint(equalTo: youBox.trailingAnchor, constant: 8),
            youLabel.centerYAnchor.constraint(equalTo: youBox.centerYAnchor),
            
            twitchLabel.leadingAnchor.constraint(equalTo: twitchBox.trailingAnchor, constant: 8),
            twitchLabel.centerYAnchor.constraint(equalTo: twitchBox.centerYAnchor),
            
            onlyLabel.leadingAnchor.constraint(equalTo: onlyBox.trailingAnchor, constant: 8),
            onlyLabel.centerYAnchor.constraint(equalTo: onlyBox.centerYAnchor),
            
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            applyButton.heightAnchor.constraint(equalToConstant: 50),
            applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    // MARK: - Functions
    
    @objc func applyButtonDidTapped(_ sender: UIButton) {
//        guard let vc = view.window?.rootViewController as? NewCollabViewController else {return}
//        vc.platforms.append("Instagram")
        var newPlatforms = [String]()
        if instaBox.isSelected {
            newPlatforms.append("Skype")
        }
        if tikBox.isSelected {
            newPlatforms.append("Teams")
        }
        if youBox.isSelected {
            newPlatforms.append("Zoom")
        }
        if twitchBox.isSelected {
            newPlatforms.append("On-site")
        }
        if onlyBox.isSelected {
            newPlatforms.append("Other")
        }
        self.platforms = newPlatforms
        
        delegate?.platformsWereChosen(platforms)
        self.dismiss(animated: true)
 
    }
    
    @objc func closeDidTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    @objc func boxDidTapped(_ sender: UIButton){
        sender.isSelected.toggle()
    }


}

protocol SocialMediaDelegate: AnyObject {
    func platformsWereChosen(_ platforms: [String])
}
