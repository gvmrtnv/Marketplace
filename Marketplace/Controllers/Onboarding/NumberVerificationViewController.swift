//
//  NumberVerificationViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 10.02.22.
//

import UIKit

class NumberVerificationViewController: UIViewController {
    
    
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
    
    private lazy var verifyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Verify your number"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "verification")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var number: FieldView =  {
        let view = FieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let imageConfig1 = UIImage.SymbolConfiguration(pointSize: 16)
        view.textField.placeholder = "+49458793820"
        view.icon.image = UIImage(systemName: "phone", withConfiguration: imageConfig1)
        view.icon.tintColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        return view
    }()
    
    private lazy var enterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your phone number to verify \n your identity"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var NextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(nextButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        let backgroundLayer = BackgroundLayer.gradient
//        backgroundLayer.frame = view.bounds
//        view.layer.insertSublayer(backgroundLayer, at: 0)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(verifyLabel)
        contenView.addSubview(imageView)
        contenView.addSubview(number)
        contenView.addSubview(enterLabel)
        contenView.addSubview(NextButton)
        
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
            
            verifyLabel.topAnchor.constraint(equalTo: contenView.safeAreaLayoutGuide.topAnchor, constant: 105),
            verifyLabel.centerXAnchor.constraint(equalTo: contenView.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: verifyLabel.bottomAnchor, constant: 11),
            imageView.centerXAnchor.constraint(equalTo: contenView.centerXAnchor, constant: 23),
            imageView.heightAnchor.constraint(equalToConstant: 176),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            number.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            number.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            number.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            number.heightAnchor.constraint(equalToConstant: 56),
            
            enterLabel.topAnchor.constraint(equalTo: number.bottomAnchor, constant: 25),
            enterLabel.centerXAnchor.constraint(equalTo: contenView.centerXAnchor),
            
            NextButton.topAnchor.constraint(equalTo: enterLabel.bottomAnchor, constant: 60),
            NextButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            NextButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            NextButton.heightAnchor.constraint(equalToConstant: 50),
            
            NextButton.bottomAnchor.constraint(equalTo: contenView.bottomAnchor)
            
        ]
    
        NSLayoutConstraint.activate(constraints)
        

        self.number.textField.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        self.number.generateShadow()
       
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
    
    
        // MARK: - Actions


   @objc func nextButtonDidTapped(_ sender: Any) {
        number.resignFirstResponder()
       let vc = InfluencerAccountInfoViewController()
       navigationController?.pushViewController(vc, animated: true)
    }

}


        
    extension NumberVerificationViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.switchBasedNextTextField(textField)
            return true
        }
        
        func switchBasedNextTextField(_ textField: UITextField) {
                self.number.textField.resignFirstResponder()
            
        }
        
       
    }

