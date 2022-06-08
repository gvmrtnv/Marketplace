//
//  ContentSelectionViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 04.03.22.
//

import UIKit

class ContentSelectionViewController: UIViewController {

    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Service"
        label.font = .boldSystemFont(ofSize: 21)
        return label
    }()
    
    private lazy var storyField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelected = false
        view.autocorrectionType = .no
        view.keyboardType = .decimalPad
        view.layer.borderColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var postField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelected = false
        view.autocorrectionType = .no
        view.keyboardType = .decimalPad
        view.layer.borderColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    private lazy var reelField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelected = false
        view.autocorrectionType = .no
        view.keyboardType = .decimalPad
        view.layer.borderColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    private lazy var videoField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelected = false
        view.autocorrectionType = .no
        view.keyboardType = .decimalPad
        view.layer.borderColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    private lazy var bilderField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelected = false
        view.autocorrectionType = .no
        view.keyboardType = .decimalPad
        view.layer.borderColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    private lazy var buyoutField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelected = false
        view.autocorrectionType = .no
        view.keyboardType = .decimalPad
        view.layer.borderColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    
    private lazy var storyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Academic hour/s"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Online hour/s"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var reelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Onsite hour/s"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var videoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Travel hour/s"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var buildLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Consumable/s"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var buyOutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Extra/s"
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
    
    var content = [Content]()
    weak var delegate: ContentSelectionDelegate?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        
        view.addSubview(storyField)
        view.addSubview(postField)
        view.addSubview(reelField)
        view.addSubview(videoField)
        view.addSubview(bilderField)
        view.addSubview(buyoutField)
        
        view.addSubview(storyLabel)
        view.addSubview(postLabel)
        view.addSubview(reelLabel)
        view.addSubview(videoLabel)
        view.addSubview(buildLabel)
        view.addSubview(buyOutLabel)
        
        view.addSubview(applyButton)
        
       
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 13),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 13),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            storyField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            storyField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            storyField.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
            storyField.heightAnchor.constraint(equalToConstant: 24),
            
            postField.topAnchor.constraint(equalTo: storyField.bottomAnchor, constant: 16),
            postField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            postField.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
            postField.heightAnchor.constraint(equalToConstant: 24),
            
            reelField.topAnchor.constraint(equalTo: postField.bottomAnchor, constant: 16),
            reelField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            reelField.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
            reelField.heightAnchor.constraint(equalToConstant: 24),
            
            videoField.topAnchor.constraint(equalTo: reelField.bottomAnchor, constant: 16),
            videoField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            videoField.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
            videoField.heightAnchor.constraint(equalToConstant: 24),
            
            bilderField.topAnchor.constraint(equalTo: videoField.bottomAnchor, constant: 16),
            bilderField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bilderField.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
            bilderField.heightAnchor.constraint(equalToConstant: 24),
            
            buyoutField.topAnchor.constraint(equalTo: bilderField.bottomAnchor, constant: 16),
            buyoutField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buyoutField.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
            buyoutField.heightAnchor.constraint(equalToConstant: 24),
            
            storyLabel.leadingAnchor.constraint(equalTo: storyField.trailingAnchor, constant: 8),
            storyLabel.centerYAnchor.constraint(equalTo: storyField.centerYAnchor),
            
            postLabel.leadingAnchor.constraint(equalTo: postField.trailingAnchor, constant: 8),
            postLabel.centerYAnchor.constraint(equalTo: postField.centerYAnchor),
            
            reelLabel.leadingAnchor.constraint(equalTo: reelField.trailingAnchor, constant: 8),
            reelLabel.centerYAnchor.constraint(equalTo: reelField.centerYAnchor),
            
            videoLabel.leadingAnchor.constraint(equalTo: videoField.trailingAnchor, constant: 8),
            videoLabel.centerYAnchor.constraint(equalTo: videoField.centerYAnchor),
            
            buildLabel.leadingAnchor.constraint(equalTo: bilderField.trailingAnchor, constant: 8),
            buildLabel.centerYAnchor.constraint(equalTo: bilderField.centerYAnchor),
            
            buyOutLabel.leadingAnchor.constraint(equalTo: buyoutField.trailingAnchor, constant: 8),
            buyOutLabel.centerYAnchor.constraint(equalTo: buyoutField.centerYAnchor),
            
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            applyButton.heightAnchor.constraint(equalToConstant: 50),
            applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        storyField.delegate = self
        postField.delegate = self
        reelField.delegate = self
        videoField.delegate = self
        bilderField.delegate = self
        buyoutField.delegate = self
        
        content.forEach { content in
            switch content.title {
            case "Academic hour/s":
                guard let number = content.number else {return}
                storyField.text = String(number)
            case "Online hour/s":
                guard let number = content.number else {return}
                postField.text = String(number)
            case "Onsite hour/s":
                guard let number = content.number else {return}
                reelField.text = String(number)
            case "Travel hour/s":
                guard let number = content.number else {return}
                videoField.text = String(number)
            case "Consumable/s":
                guard let number = content.number else {return}
                bilderField.text = String(number)
            case "Extra/s":
                guard let number = content.number else {return}
                buyoutField.text = String(number)
            
            default:
                return
//            case "Story/s":
//                guard let number = content.number else {return}
//                storyField.text = String(number)
//            case "Story/s":
//                guard let number = content.number else {return}
//                storyField.text = String(number)
            
            
            }
        }
       
    }
    
    
    // MARK: - Functions
    
    @objc func applyButtonDidTapped(_ sender: UIButton) {
        var newContent = [Content]()
        
        var storyNumber: Int?
        if let storyString = storyField.text,
           let number = Int(storyString) {
            storyNumber = number
        }
        newContent.append(Content(title: "Academic hour/s", number: storyNumber))
        
        var postNumber: Int?
        if let storyString = postField.text,
           let number = Int(storyString) {
            postNumber = number
        }
        newContent.append(Content(title: "Online hour/s", number: postNumber))
        
        var reelNumber: Int?
        if let storyString = reelField.text,
           let number = Int(storyString) {
            reelNumber = number
        }
        newContent.append(Content(title: "Onsite hour/s", number: reelNumber))
        
        var videoNumber: Int?
        if let storyString = videoField.text,
           let number = Int(storyString) {
            videoNumber = number
        }
        newContent.append(Content(title: "Travel hour/s", number: videoNumber))
        
        var pictureNumber: Int?
        if let storyString = bilderField.text,
           let number = Int(storyString) {
            pictureNumber = number
        }
        newContent.append(Content(title: "Consumable/s", number: pictureNumber))
        
        var buyNumber: Int?
        if let storyString = videoField.text,
           let number = Int(storyString) {
            buyNumber = number
        }
        newContent.append(Content(title: "Extra/s", number: buyNumber))
       
        
        self.content = newContent
        delegate?.contentWasChosen(content)
        
        self.dismiss(animated: true)


    }
    
    @objc func closeDidTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    


}

protocol ContentSelectionDelegate: AnyObject {
    func contentWasChosen(_ content: [Content])
}


extension ContentSelectionViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        
        case self.storyField:
            self.postField.becomeFirstResponder()
        case self.postField:
            self.reelField.becomeFirstResponder()
        case self.reelField:
            self.videoField.becomeFirstResponder()
        case self.videoField:
            self.bilderField.becomeFirstResponder()
        case self.bilderField:
            self.buyoutField.becomeFirstResponder()
        default:
            self.buyoutField.resignFirstResponder()
        }
    }
    

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {return true}
        if let _ = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {return true}
        else {return false}
    }
    
}
