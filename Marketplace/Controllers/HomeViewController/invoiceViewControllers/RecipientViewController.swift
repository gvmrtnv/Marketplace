//
//  RecipientViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 28.02.22.
//

import UIKit

class RecipientViewController: UIViewController {

    //MARK: - Views
    
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
    
    
    private lazy var titleLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recipient information"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()

    private lazy var nameField: InvoiceFieldView = {
        let view = InvoiceFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Name"
        
        return view
    }()
    private lazy var lastNameField: InvoiceFieldView = {
        let view = InvoiceFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Last name"
        
        return view
    }()
    private lazy var companyNameField: InvoiceFieldView = {
        let view = InvoiceFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Company name"
        
        return view
    }()
    private lazy var addressField: InvoiceFieldView = {
        let view = InvoiceFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Address"
        
        return view
    }()
    private lazy var taxNumberField: InvoiceFieldView = {
        let view = InvoiceFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Tax number"
        view.textField.keyboardType = .decimalPad
        
        return view
    }()

    
    private lazy var statusBar: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "statusLine2")
        
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(nextButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
   
    
    //MARK: - Values
    
    var invoice: Invoice!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(titleLabel)
       
        contenView.addSubview(nameField)
        contenView.addSubview(lastNameField)
        contenView.addSubview(companyNameField)
        contenView.addSubview(addressField)
        contenView.addSubview(taxNumberField)
 
        contenView.addSubview(statusBar)
        contenView.addSubview(nextButton)
        
        let constraints = [
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            contenView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contenView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contenView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contenView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contenView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contenView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            
 
            
            nameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            nameField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
            lastNameField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            lastNameField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            lastNameField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
            companyNameField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 16),
            companyNameField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            companyNameField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
            addressField.topAnchor.constraint(equalTo: companyNameField.bottomAnchor, constant: 16),
            addressField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            addressField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
            taxNumberField.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: 16),
            taxNumberField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            taxNumberField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
        
            
            statusBar.topAnchor.constraint(equalTo: taxNumberField.bottomAnchor, constant: 40),
            statusBar.heightAnchor.constraint(equalToConstant: 4),
            statusBar.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            statusBar.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
            nextButton.topAnchor.constraint(equalTo: statusBar.bottomAnchor, constant: 16),
            nextButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.bottomAnchor.constraint(equalTo: contenView.bottomAnchor, constant: -16)
        
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        nameField.textField.delegate = self
        lastNameField.textField.delegate = self
        companyNameField.textField.delegate = self
        addressField.textField.delegate = self
        taxNumberField.textField.delegate = self
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
    @objc func nextButtonDidTapped (_ sender: Any) {
        if let recName = nameField.textField.text,
           let recLastName = lastNameField.textField.text,
           let recCompanyName = companyNameField.textField.text,
           let recAddress = addressField.textField.text,
           let recTaxNumber = taxNumberField.textField.text,
           !recName.isEmpty,
           !recLastName.isEmpty,
           !recCompanyName.isEmpty,
           !recAddress.isEmpty,
           !recTaxNumber.isEmpty {
            invoice.recName = recName
            invoice.recLastName = recLastName
            invoice.recCompanyName = recCompanyName
            invoice.recAddress = recAddress
            invoice.recTaxNumber = recTaxNumber
            let vc = OtherInfoViewController()
            vc.invoice = self.invoice
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let ac = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
        
        
        
    }
     
}




extension RecipientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.nameField.textField:
            self.lastNameField.textField.becomeFirstResponder()
        case self.lastNameField.textField:
            self.companyNameField.textField.becomeFirstResponder()
        case self.companyNameField.textField:
            self.addressField.textField.becomeFirstResponder()
        case self.addressField.textField:
            self.taxNumberField.textField.becomeFirstResponder()
        default:
            self.taxNumberField.textField.resignFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {return true}
        if textField == taxNumberField.textField {
            if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
                return true
            } else {return false}
        } else {return true}
    }
    
   
}
