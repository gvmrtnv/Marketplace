//
//  OtherInfoViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 28.02.22.
//

import UIKit

class OtherInfoViewController: UIViewController {
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
        label.text = "Other information"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()

   
    
    public lazy var serviceView: InvoiceShadowTextView = {
        let view = InvoiceShadowTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.titleLabel.text = "Service"
        return view
    }()
    
    private lazy var compensationField: InvoiceFieldView = {
        let view = InvoiceFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Compensation amount"
        view.textField.keyboardType = .decimalPad
        return view
    }()
    
    private lazy var taxLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Apply tax"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var taxSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTintColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00)
        
        return view
    }()
    
    public lazy var taxField: TextShadowField = {
        let textField = TextShadowField()
        textField.font = .systemFont(ofSize: 16)
        textField.layer.cornerRadius = 14
        textField.backgroundColor = .white
        textField.placeholder = "%"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.keyboardType = .decimalPad
//        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var brandField: InvoiceFieldView = {
        let view = InvoiceFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Brand"
        
        return view
    }()
    private lazy var invoiceField: InvoiceFieldView = {
        let view = InvoiceFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Invoice number"
        view.textField.keyboardType = .decimalPad
        
        return view
    }()
    private lazy var datePicker: ShadowDatePicker = {
        let view = ShadowDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.timeZone = NSTimeZone.local
        view.addTarget(self, action: #selector(datePickerDidChanged(_:)), for: .valueChanged)
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .compact
        view.contentHorizontalAlignment = .left
        view.backgroundColor = .white
     
        view.layer.cornerRadius = 14
    
        
        
        return view
    }()

    private lazy var statusBar: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "statusLine3")
        
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
    var deadline: TimeInterval?

    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(titleLabel)
        contenView.addSubview(serviceView)
        contenView.addSubview(compensationField)
        contenView.addSubview(taxLabel)
        contenView.addSubview(taxSwitch)
        contenView.addSubview(taxField)
        contenView.addSubview(brandField)
        contenView.addSubview(invoiceField)
        contenView.addSubview(datePicker)
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
            
            serviceView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            serviceView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            serviceView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
          
            
            compensationField.topAnchor.constraint(equalTo: serviceView.bottomAnchor, constant: 16),
            compensationField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            compensationField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
            taxLabel.topAnchor.constraint(equalTo: compensationField.bottomAnchor, constant: 16),
            taxLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            
            taxSwitch.topAnchor.constraint(equalTo: taxLabel.bottomAnchor, constant: 18),
            taxSwitch.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            taxSwitch.widthAnchor.constraint(equalToConstant: 51),
            taxSwitch.heightAnchor.constraint(equalToConstant: 31),
 
            taxField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            taxField.centerYAnchor.constraint(equalTo: taxSwitch.centerYAnchor),
            taxField.widthAnchor.constraint(equalToConstant: 164),
            taxField.heightAnchor.constraint(equalToConstant: 56),
            
            brandField.topAnchor.constraint(equalTo: taxSwitch.bottomAnchor, constant: 27),
            brandField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            brandField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
            invoiceField.topAnchor.constraint(equalTo: brandField.bottomAnchor, constant: 27),
            invoiceField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            invoiceField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
            
            datePicker.topAnchor.constraint(equalTo: invoiceField.bottomAnchor, constant: 27),
            datePicker.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            datePicker.heightAnchor.constraint(equalToConstant: 56),
            
            statusBar.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 40),
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
        
        compensationField.textField.delegate = self
        taxField.delegate = self
        brandField.textField.delegate = self
        invoiceField.textField.delegate = self
        
       
        serviceView.textView.text = invoice.collab.note
        compensationField.textField.text = invoice.collab.revard
        brandField.textField.text = invoice.collab.brand
        
    }
    
    // MARK: - Keyboard behaviour
        
    override func viewDidLayoutSubviews() {
      
    }
    
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
        
        
        if let service = serviceView.textView.text,
           let compensation = compensationField.textField.text,
      
           let brand = brandField.textField.text,
           let invoiceNumber = invoiceField.textField.text,
           let date = deadline,
           !service.isEmpty,
           !compensation.isEmpty,
      
           !brand.isEmpty,
           !invoiceNumber.isEmpty {
            if let taxPercent = taxField.text,
               !taxPercent.isEmpty,
               taxSwitch.isOn ||
                !taxSwitch.isOn
            {
                invoice.service = service
                invoice.compensation = compensation
                if taxSwitch.isOn {
                    invoice.taxPercent = taxPercent
                }
                invoice.brand = brand
                invoice.invoiceNumber = invoiceNumber
                invoice.date = date
                let vc = PreviewInvoiceViewController()
                vc.invoice = self.invoice
                navigationController?.pushViewController(vc, animated: true)
            }
            else {
                let ac = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        }
        else {
            let ac = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
      
    }
    
    @objc func datePickerDidChanged(_ sender: UIDatePicker) {
        deadline = sender.date.timeIntervalSince1970
    }

}


extension OtherInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        
        case self.compensationField.textField:
            self.taxField.becomeFirstResponder()
        case self.taxField:
            self.brandField.textField.becomeFirstResponder()
        case self.brandField.textField:
            self.invoiceField.textField.becomeFirstResponder()
        default:
            self.invoiceField.textField.resignFirstResponder()
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {return true}
      
        if textField == taxField {
            if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil || string.rangeOfCharacter(from: NSCharacterSet.punctuationCharacters) != nil {
                return true
            } else {return false}
        }
        
        else if textField == compensationField.textField ||
                textField == invoiceField.textField {
            if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
                return true
            } else {return false}
        } else {return true}
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case compensationField.textField:
            guard let amountString = textField.text?.currencyInputFormatting() else {return}
          

            textField.text = amountString
        
        case taxField:
            guard let amountString = textField.text?.percentInputFormatting() else {return}
         

            textField.text = amountString
    
        default:
            break
        }
    }
   
}

extension OtherInfoViewController: UITextViewDelegate {
    

//    func textViewDidBeginEditing(_ textView: UITextView) {
//        textView.textColor = .black
//        textView.text = nil
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "Add text"
//            textView.textColor = .lightGray
//        }
//    }
}

