//
//  SignUpViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 16.01.22.
//

import UIKit

class SignUpViewController: UIViewController {

    
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
    
    private lazy var email: FieldView =  {
        let view = FieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let imageConfig1 = UIImage.SymbolConfiguration(pointSize: 14)
        view.textField.placeholder = "Email"
        view.icon.image = UIImage(systemName: "envelope", withConfiguration: imageConfig1)
        view.icon.tintColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        return view
    }()
    
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
    
    private lazy var showButton2: UIButton = {
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
        
        button.addTarget(self, action: #selector(showButton2DidTapped(_:)), for: .touchUpInside)
        
        return button
    }()

    
    private lazy var password:FieldView = {
        let view = FieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageConfig2 = UIImage.SymbolConfiguration(pointSize: 16)
        view.textField.placeholder = "Password"
        view.textField.rightView = showButton
        view.textField.rightViewMode = .unlessEditing
        view.textField.isSecureTextEntry = true
        
        view.icon.image = UIImage(systemName: "lock", withConfiguration: imageConfig2)
        view.icon.tintColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        return view
    }()
    
    private lazy var repeatPassword:FieldView = {
        let view = FieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageConfig2 = UIImage.SymbolConfiguration(pointSize: 16)
        view.textField.placeholder = "Repeat password"
        view.textField.rightView = showButton2
        view.textField.rightViewMode = .unlessEditing
        view.textField.isSecureTextEntry = true
        
        view.icon.image = UIImage(systemName: "lock", withConfiguration: imageConfig2)
        view.icon.tintColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        return view
    }()
    
    private lazy var agreeBox: CheckBox = {
        let box = CheckBox()
        box.addTarget(self, action: #selector(agreeDidTapped), for: .touchUpInside)
        return box
    }()
    
    @objc func agreeDidTapped (_ sender: UIButton) {
        sender.isSelected.toggle()
        isAgreed.toggle()
    }
    
    private lazy var labelAgree: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I am agree with Terms and Conditions"
        label.font = .systemFont(ofSize: 16)
        return label
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
    
    private var isAgreed: Bool = false
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
//        let gradient = BackgroundLayer().gradient
//        gradient.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
//        gradient.position = view.center
//        self.view.layer.addSublayer(gradient)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(labelCreate)
        contenView.addSubview(email)
        contenView.addSubview(password)
        contenView.addSubview(repeatPassword)
        contenView.addSubview(agreeBox)
        contenView.addSubview(labelAgree)
        contenView.addSubview(createAccountButton)
        
        
        let constraints = [
            
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
            
            labelCreate.topAnchor.constraint(equalTo: contenView.safeAreaLayoutGuide.topAnchor, constant: 105),
            labelCreate.centerXAnchor.constraint(equalTo: contenView.centerXAnchor),
            
            email.topAnchor.constraint(equalTo: labelCreate.bottomAnchor, constant: 56),
            email.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            email.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            email.heightAnchor.constraint(equalToConstant: 56),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 16),
            password.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            password.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            password.heightAnchor.constraint(equalTo: email.heightAnchor),
            
            repeatPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 16),
            repeatPassword.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            repeatPassword.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            repeatPassword.heightAnchor.constraint(equalTo: email.heightAnchor),
            
            agreeBox.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 32),
            agreeBox.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            agreeBox.widthAnchor.constraint(equalToConstant: 24),
            agreeBox.heightAnchor.constraint(equalToConstant: 24),
            
            labelAgree.leadingAnchor.constraint(equalTo: agreeBox.trailingAnchor, constant: 12),
            labelAgree.centerYAnchor.constraint(equalTo: agreeBox.centerYAnchor),
            
            createAccountButton.topAnchor.constraint(equalTo: agreeBox.bottomAnchor, constant: 40),
            createAccountButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            createAccountButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),
            
            createAccountButton.bottomAnchor.constraint(equalTo: contenView.bottomAnchor)
            
        ]
    
        NSLayoutConstraint.activate(constraints)
        

        self.email.textField.delegate = self
        self.password.textField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        self.email.generateShadow()
        self.password.generateShadow()
        self.repeatPassword.generateShadow()
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
    @objc func showButton2DidTapped(_ sender: UIButton) {
        repeatPassword.textField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }

    
        // MARK: - Actions


   @objc func createButtonDidTapped(_ sender: Any) {
        email.resignFirstResponder()
        password.resignFirstResponder()
       
//       let vc = NumberVerificationViewController()
//       self.navigationController?.pushViewController(vc, animated: true)
       
        
       guard let email = email.textField.text, !email.isEmpty,
             let password = password.textField.text, !password.isEmpty, password.count >= 8
        else {return}
        AuthManager.shared.registerNewUser(email: email, password: password) { registered in
            if registered {
                let ac = UIAlertController(title: "Verify your email", message: "Please check your mail. Otherweise you'll not be able to log in", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                    let vc = NumberVerificationViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                ac.addAction(action)
                self.present(ac, animated: true)




            }
            else {
                //failed
            }


        }
    }

}


        
    extension SignUpViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.switchBasedNextTextField(textField)
            return true
        }
        
        func switchBasedNextTextField(_ textField: UITextField) {
            switch textField {
            case self.email.textField:
                self.password.textField.becomeFirstResponder()
            case self.password.textField:
                self.repeatPassword.textField.becomeFirstResponder()
            default:
                self.repeatPassword.textField.resignFirstResponder()
            }
        }
        
       
    }

    
   
