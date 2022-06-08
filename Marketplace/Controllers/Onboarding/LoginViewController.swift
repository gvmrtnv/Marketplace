//
//  LoginViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 16.01.22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Views
    
    
//    private lazy var gradient = BackgroundGradientView()

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
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "login")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var email = FieldView()
    
    private lazy var password = FieldView()
    
    private lazy var showButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 16))

        let attr1: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.black
        ]
        let str1 = NSAttributedString(string: "Show", attributes: attr1)
        button.setAttributedTitle(str1, for: .normal)
        
        let str2 = NSAttributedString(string: "Hide", attributes: attr1)
        button.setAttributedTitle(str2, for: .selected)
        
        button.addTarget(self, action: #selector(showButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(loginButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let attr1: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.black
        ]
        let str1 = NSAttributedString(string: "Forgot Password?", attributes: attr1)
        button.setAttributedTitle(str1, for: .normal)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
     
        
        let attr1: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.black
        ]
        let str1 = NSMutableAttributedString(string: "Don't have an account? ", attributes: attr1)
        
        
        let attr2: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.black
        ]
        let str2 = NSMutableAttributedString(string: "Sign up", attributes: attr2)
        str1.append(str2)
        button.setAttributedTitle(str1, for: .normal)
        
        button.addTarget(self, action: #selector(signUpButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    


    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
//        let gradient = BackgroundLayer().gradient
//        gradient.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
//        gradient.position = view.center
//        view.layer.addSublayer(gradient)
//        view.addSubview(gradient)
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(imageView)
        contenView.addSubview(email)
        contenView.addSubview(password)
        contenView.addSubview(loginButton)
        contenView.addSubview(forgotPasswordButton)
        contenView.addSubview(signUpButton)
        
        
        let imageConfig1 = UIImage.SymbolConfiguration(pointSize: 14)
        email.textField.placeholder = "Email"
        email.icon.image = UIImage(systemName: "envelope", withConfiguration: imageConfig1)
        email.icon.tintColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        
        let imageConfig2 = UIImage.SymbolConfiguration(pointSize: 16)
        password.textField.placeholder = "Password"
        password.textField.rightView = showButton
        password.textField.rightViewMode = .unlessEditing
        password.textField.isSecureTextEntry = true
        
        password.icon.image = UIImage(systemName: "lock", withConfiguration: imageConfig2)
        password.icon.tintColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        
        let constraints = [
            
//            gradient.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
//            gradient.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
//            gradient.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            gradient.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
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
            
            imageView.topAnchor.constraint(equalTo: contenView.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier:  868/912),
            
            email.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            email.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            email.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            email.heightAnchor.constraint(equalToConstant: 56),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 16),
            password.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            password.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            password.heightAnchor.constraint(equalTo: email.heightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: contenView.centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 12),
            signUpButton.centerXAnchor.constraint(equalTo: contenView.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: contenView.bottomAnchor)
            
        ]
    
        NSLayoutConstraint.activate(constraints)
        
        self.email.textField.delegate = self
        self.password.textField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        email.generateShadow()
        password.generateShadow()
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
    
    @objc func showButtonDidTapped(_ sender: UIButton) {
        password.textField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    // MARK: - Actions
    
    
    @objc func loginButtonDidTapped(_ sender: Any) {
        password.resignFirstResponder()
        email.resignFirstResponder()
        
        guard let emailField = email.textField.text, !emailField.isEmpty, let password = password.textField.text, !password.isEmpty, password.count >= 8 else {return}
        
        //login functionality
        var logUsername: String?
        var logEmail: String?
        if emailField.contains("@"), emailField.contains(".") {
            //email
            logEmail = emailField
        }
        else {
            //username
            logUsername = emailField
        }
        AuthManager.shared.loginUser(username: logUsername, email: logEmail, password: password) { status in
            switch status {
            case .success:
                //user logged in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                delegate?.changeRootViewController(vc, animated: true)
            
            case .failure:
                // error occured
                let alert = UIAlertController(title: "Log in Error", message: "We were unable to log you in.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            case .notVerified:
                let alert = UIAlertController(title: "Email is not verified", message: "Check your mail and verify it please", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc func signUpButtonDidTapped(_ sender: Any) {
       
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.email.textField:
            self.password.textField.becomeFirstResponder()
        default:
            self.password.textField.resignFirstResponder()
        }
    }
    
   
}
