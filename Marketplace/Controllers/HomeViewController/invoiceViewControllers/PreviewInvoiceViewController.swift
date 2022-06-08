//
//  previewInvoiceViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 28.02.22.
//

import UIKit
import PDFKit

class PreviewInvoiceViewController: UIViewController {

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
        label.text = "Preview"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()

   
    private lazy var titleField: InvoiceFieldView = {
        let view = InvoiceFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Name of file"
        view.textField.keyboardType = .decimalPad
        return view
    }()
    
    private lazy var previewView: PDFView = {
        let view = PDFView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.pageShadowsEnabled = false
        view.layer.cornerRadius = 20
   
        return view
    }()
    
    private lazy var shadowView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var statusBar: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "statusLine4")
        
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save and share", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(nextButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
   
    
    //MARK: - Values
    
    var invoice: Invoice! {
        didSet {
            pdfTitle = "Invoice for \(invoice.brand!).pdf"
            titleField.textField.text = pdfTitle
        }
    }
//    var deadline: TimeInterval?
//    var compensation: String?
//    var tax: String?
//
    var documentData: Data?
    var pdfTitle: String!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(titleLabel)
      
        contenView.addSubview(titleField)
        contenView.addSubview(shadowView)
        contenView.addSubview(previewView)
       
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
            
            
            titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            titleField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            
            shadowView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 16),
            shadowView.leadingAnchor.constraint(equalTo: previewView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: previewView.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: previewView.bottomAnchor),
            
            previewView.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 20),
            previewView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            previewView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            previewView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -20),
            previewView.heightAnchor.constraint(greaterThanOrEqualTo: previewView.widthAnchor, multiplier: 11.69 / 8.27),
            
            statusBar.topAnchor.constraint(greaterThanOrEqualTo: shadowView.bottomAnchor, constant: 32),
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
        
        titleField.textField.delegate = self
        
        updatePdf()
      
        
       
    }
    
//    override func viewDidLayoutSubviews() {
//
//        generateShadow(for: previewView)
//    }
//
//    func generateShadow(for view: UIView) {
//        view.layer.shouldRasterize = true
//        view.layer.rasterizationScale = UIScreen.main.scale
//        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
//        view.layer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
//        view.layer.shadowOpacity = 1
//        view.layer.shadowRadius = 10
//        view.layer.shadowOffset = .zero
//    }
    

    
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
    
    func updatePdf () {
        let pdfCreator = PDFCreator(invoice: invoice, invTitle: titleField.textField.text!)
        documentData = pdfCreator.createInvoice()
        if let data = documentData {
            previewView.document = PDFDocument(data: data)
            previewView.autoScales = true
        }
    }
    
    @objc func nextButtonDidTapped (_ sender: Any) {
        
        updatePdf()
        if let documentData = documentData,
           pdfTitle.count > 4 {
            StorageManager.shared.uploadInvoice(documentData, withName: pdfTitle, forCollab: invoice.collabKey, inFolder: invoice.cfid) { success in
                if success {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        else {
            let ac = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }

    }
    
    


}


extension PreviewInvoiceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        default:
            self.titleField.textField.resignFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           text.suffix(4) != ".pdf" {
            textField.text = text + ".pdf"
        }
        pdfTitle = textField.text
    }
    
    
   
}

