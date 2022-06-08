//
//  InfluencerAccountInfoViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 11.02.22.
//

import UIKit
import SKCountryPicker
import Kingfisher
import FirebaseAuth

class InfluencerAccountInfoViewController: UIViewController {
    
    
    // MARK: - Views
    
    private lazy var contenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelCreate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create your account"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 16

        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "emptyAvatar")
        imageView.image = image
        
        return imageView
    }()
    
    private lazy var addPictureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        let attr1: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.black
        ]
        let str1 = NSAttributedString(string: "Add picture", attributes: attr1)
        button.setAttributedTitle(str1, for: .normal)
        
        let str2 = NSAttributedString(string: "Change picture", attributes: attr1)
        button.setAttributedTitle(str2, for: .selected)
        button.contentHorizontalAlignment = .left
        
        button.addTarget(self, action: #selector(addImageDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Last name"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Username"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Region"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Gender"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var nameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        field.placeholder = "Alice"
        field.font = .systemFont(ofSize: 16)
        field.autocorrectionType = .no
        field.textAlignment = .left
        
        field.layer.cornerRadius = 14
        field.backgroundColor = .white
        
        return field
    }()
    
    private lazy var lastNameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        field.placeholder = "Smith"
        field.font = .systemFont(ofSize: 16)
        field.layer.cornerRadius = 14
        
        field.autocorrectionType = .no
        field.backgroundColor = .white
        return field
    }()
    
    private lazy var userNameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        field.placeholder = "username"
        field.font = .systemFont(ofSize: 16)
        field.layer.cornerRadius = 14
        
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.backgroundColor = .white
        
        return field
    }()
    
    private lazy var regionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Germany", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left
        
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(regionButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var genderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Female", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(genderButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        
        
    

        
        button.addTarget(self, action: #selector(createButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Values
    
    let userRole = "Influencer"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(labelCreate)
        contenView.addSubview(imageView)
        contenView.addSubview(addPictureButton)
        contenView.addSubview(nameLabel)
        contenView.addSubview(nameField)
        contenView.addSubview(userNameLabel)
        contenView.addSubview(userNameField)
        contenView.addSubview(regionLabel)
        contenView.addSubview(regionButton)
        contenView.addSubview(createAccountButton)
        
        var constraints = [
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            contenView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contenView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contenView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contenView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contenView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            
            labelCreate.topAnchor.constraint(equalTo: contenView.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelCreate.centerXAnchor.constraint(equalTo: contenView.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: labelCreate.bottomAnchor, constant: 24),
            imageView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            addPictureButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            addPictureButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            addPictureButton.heightAnchor.constraint(equalToConstant: 40),
            addPictureButton.widthAnchor.constraint(equalToConstant: 250),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            nameField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            nameField.heightAnchor.constraint(equalToConstant: 56),
            nameField.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            userNameLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: userNameField.leadingAnchor),
            
            userNameField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
            userNameField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            userNameField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            userNameField.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            
            regionLabel.topAnchor.constraint(equalTo: userNameField.bottomAnchor, constant: 16),
            regionLabel.leadingAnchor.constraint(equalTo: regionButton.leadingAnchor),
            
            regionButton.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 4),
            regionButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            regionButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            regionButton.heightAnchor.constraint(equalTo: userNameField.heightAnchor)
            ]
        
        
        if self.userRole == "Influencer" || self.userRole == "Manager" {
            contenView.addSubview(lastNameLabel)
            contenView.addSubview(lastNameField)
            contenView.addSubview(genderLabel)
            contenView.addSubview(genderButton)
            
        
        let influencerConstraints = [
            
            lastNameLabel.leadingAnchor.constraint(equalTo: lastNameField.leadingAnchor),
            lastNameLabel.bottomAnchor.constraint(equalTo: lastNameField.topAnchor, constant: 4),
            
            lastNameField.leadingAnchor.constraint(equalTo: nameField.trailingAnchor, constant: 16),
            lastNameField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            lastNameField.centerYAnchor.constraint(equalTo: nameField.centerYAnchor),
            lastNameField.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            lastNameField.widthAnchor.constraint(equalTo: nameField.widthAnchor),
            
           
            genderLabel.topAnchor.constraint(equalTo: regionButton.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: genderButton.leadingAnchor),
            
            genderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 4),
            genderButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            genderButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            genderButton.heightAnchor.constraint(equalTo: regionButton.heightAnchor),
            
            createAccountButton.topAnchor.constraint(equalTo: genderButton.bottomAnchor, constant: 48),
            createAccountButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            createAccountButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),
            createAccountButton.bottomAnchor.constraint(equalTo: contenView.bottomAnchor, constant: -50)
            
            ]
            constraints += influencerConstraints
        
        } else {
            let brandConstraints = [
            createAccountButton.topAnchor.constraint(equalTo: regionButton.bottomAnchor, constant: 48),
            createAccountButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            createAccountButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),
            createAccountButton.bottomAnchor.constraint(equalTo: contenView.bottomAnchor, constant: -50)
            
            ]
            constraints += brandConstraints
        }
        
        NSLayoutConstraint.activate(constraints)
        
        
        DatabaseManager.shared.getUserDataOnce { user in
            self.nameField.text = user.name
            self.userNameField.text = user.username
            
            
            self.lastNameField.text = user.secondName
            
            
            if let url = user.profilePhoto {
                self.imageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "emptyAvatar"), completionHandler: {_, error, _, _ in
                        if let error = error {
                            print(error.localizedDescription)
                           
                        }
                    })
            }
        }
    
        nameField.delegate = self
        lastNameField.delegate = self
        userNameField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        generateShadow(for: nameField)
        generateShadow(for: lastNameField)
        generateShadow(for: userNameField)
        generateShadow(for: regionButton)
        generateShadow(for: genderButton)
    }
    
    func generateShadow(for view: UIView) {
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = .zero
    }
    
    // MARK: - Keyboard behaviour
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            registerKeyboardNotifications()
            
            let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
            view.addGestureRecognizer(tapGesture)
        }
        func registerKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)) , name: UIResponder.keyboardDidShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),name: UIResponder.keyboardWillHideNotification, object: nil)
            
        }
        
        @objc func keyboardWillShow(notification: NSNotification) {
            let userInfo: NSDictionary = notification.userInfo! as NSDictionary
            let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
            let keyboardSize = keyboardInfo.cgRectValue.size
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }

        @objc func keyboardWillHide(notification: NSNotification) {
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(self)
        }
    
    
    
    
    
// MARK: - Functions
   
    @objc func addImageDidTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    @objc func regionButtonDidTapped(_ sender: Any) {
        CountryPickerWithSectionViewController.presentController(on: self, configuration: { countryController in
            countryController.configuration.flagStyle = .corner
            countryController.configuration.isCountryFlagHidden = false
            countryController.configuration.isCountryDialHidden = true
            countryController.favoriteCountriesLocaleIdentifiers = ["DE","AT","CH","LU","GB","US"]
        }) { [weak self] country in
            self?.regionButton.setTitle(country.countryName, for: .normal)
        }
     }
    @objc func genderButtonDidTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Gender", message: "Select your gender", preferredStyle: .actionSheet)
        let femaleAction = UIAlertAction(title: "Female", style: .default) { action in

            self.genderButton.setTitle(action.title, for: .normal)
        }
        let maleAction = UIAlertAction(title: "Male", style: .default) { action in
            self.genderButton.setTitle(action.title, for: .normal)
        }
        let diverseAction = UIAlertAction(title: "Diverse", style: .default) { action in
            self.genderButton.setTitle(action.title, for: .normal)
        }
        
        ac.addAction(femaleAction)
        ac.addAction(maleAction)
        ac.addAction(diverseAction)
        self.present(ac, animated: true)
     }
   
    
    @objc func createButtonDidTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "Create Account" {
            if self.userRole == "Influencer" || self.userRole == "Manager" {
                guard let name = nameField.text, name.count >= 2,
                      let secondName = lastNameField.text, secondName.count >= 2,
                      let userName = userNameField.text, userName.count >= 2,
                      let region = regionButton.titleLabel!.text,
                      let gender = genderButton.titleLabel!.text
                else {
                    let ac = UIAlertController(title: "Error", message: "Fill in all fields please", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    return
                }
                guard let user = Auth.auth().currentUser else {return}
                let userID = user.uid
                let update = ["/users/\(userID)/name": name,
                              "/users/\(userID)/secondname": secondName,
                              "/users/\(userID)/username": userName,
                              "/users/\(userID)/region": region,
                              "/users/\(userID)/gender": gender
                ]
                DatabaseManager.shared.updateUserData(with: update)
            }
            else {
                guard let name = nameField.text, name.count >= 2,
                      
                      let userName = userNameField.text, userName.count >= 2,
                      let region = regionButton.titleLabel!.text
                 
                else {
                    let ac = UIAlertController(title: "Error", message: "Fill in all fields please", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    return
                }
                guard let user = Auth.auth().currentUser else {return}
                let userID = user.uid
                let update = ["/users/\(userID)/name": name,
                             
                              "/users/\(userID)/username": userName,
                              "/users/\(userID)/region": region,
                            
                              "/users/\(userID)/userRole": userRole,
                ]
                DatabaseManager.shared.updateUserData(with: update)
                
            }
            checkEmailVerified()
        }
        else {
            checkEmailVerified()
        }
            
        
        
        
     }
    func checkEmailVerified() {
        guard let user = Auth.auth().currentUser else {return}
        // remove True to turn on email-verification
        if user.isEmailVerified || true {
          
            let vc = HomeTabBarController()
            let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            delegate?.changeRootViewController(vc, animated: true)
        }
        else {
            let ac = UIAlertController(title: "Email is not verified ", message: "Check your mail and verify it please", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.createAccountButton.setTitle("Sign in", for: .normal)
                self.createAccountButton.role = .cancel
            }))
            self.present(ac, animated: true)
            
        }
    }
   
}

extension InfluencerAccountInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    func switchBasedNextTextField(_ textField: UITextField) {
        
        if self.userRole == "Influencer" || self.userRole == "Manager" {
            switch textField {
            case self.nameField:
                self.lastNameField.becomeFirstResponder()
            case self.lastNameField:
                self.userNameField.becomeFirstResponder()
            default:
                self.userNameField.resignFirstResponder()
            }
        }
        else {
            switch textField {
            case self.nameField:
                self.userNameField.becomeFirstResponder()
            default:
                self.userNameField.resignFirstResponder()
            }
        }
    }
}

extension InfluencerAccountInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        self.imageView.image = image
        dismiss(animated: true)
        StorageManager.shared.uploadUserFoto(image)
    }
    
}
