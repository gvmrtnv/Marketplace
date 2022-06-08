//
//  NewCollabViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 23.02.22.
//

import UIKit

class NewCollabViewController: UIViewController {
    
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
    
    private lazy var titleField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Title"
        view.font = .boldSystemFont(ofSize: 30)
        view.autocorrectionType = .no
        return view
    }()
    
    private lazy var collabTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16)
        view.text = "Add text"
        view.textColor = .lightGray
        view.autocorrectionType = .no
        
        view.isScrollEnabled = false
        return view
    }()
    
    private lazy var fieldsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
   
        
        return view
    }()
    
    private lazy var deadlinePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.timeZone = NSTimeZone.local
        view.addTarget(self, action: #selector(datePickerDidChanged(_:)), for: .valueChanged)
        view.datePickerMode = .dateAndTime
        view.preferredDatePickerStyle = .compact
        view.contentHorizontalAlignment = .center
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        
        
        return view
    }()
    
    private lazy var brandField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Name"
        view.font = .systemFont(ofSize: 16)
        view.textAlignment = .center
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var revardField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
     
        view.placeholder = "1000".currencyInputFormatting()
        view.font = .systemFont(ofSize: 16)
        view.textAlignment = .center
        view.keyboardType = .decimalPad
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var platformButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("On-site", for: .normal)
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.font = .systemFont(ofSize: 16)
        view.backgroundColor = .white
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        
        view.addTarget(self, action: #selector(platformButtonDidTapped(_:)), for: .touchUpInside)

        return view
    }()
    
    private lazy var contentButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("2 Online hour/s", for: .normal)
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.font = .systemFont(ofSize: 16)
        view.backgroundColor = .white
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        
        view.addTarget(self, action: #selector(contentButtonDidTapped(_:)), for: .touchUpInside)

        return view
    }()
    
    
    private lazy var deadlineLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Deadline:"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var brandLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Client:"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var revardLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Revard:"
        label.font = .systemFont(ofSize: 20)
        
        
        return label
    }()
    
    private lazy var platformLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Platform:"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Service:"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var contentSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTintColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00)
        return view
    }()
    
    private lazy var contentSwitchLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reciepe needed"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var feeSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTintColor = UIColor(red: 0.34, green: 0.51, blue: 0.63, alpha: 1.00)
        
        return view
    }()
    
    private lazy var feeSwitchLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enable VAT"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    

    
    
    private lazy var filesLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Files"
        label.font = .boldSystemFont(ofSize: 26)
        
        return label
    }()
    
    private lazy var noFilesLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Platform:"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private var menuTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(FileTableViewCell.self, forCellReuseIdentifier: "menu")
        view.rowHeight = 80
        view.estimatedRowHeight = 80
        view.separatorStyle = .none
        
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add File", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .white
        button.layer.cornerRadius = 14
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addFileButtonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    

    //MARK: - Values
    
//    var collabTitle: String?
//    var collabText: String?
//    var deadline: TimeInterval?
//    var revard: String?
//    var platforms = ["Instagram"]
    
//    var files = [String]()
//    var files = ["Invoice", "agreement"]
    var colTitle: String?
    var revard: String?
    var note: String?
    var deadline: TimeInterval?
    var brand: String?
    var platforms = ["Instagram"]
    var content: [Content] = {
        var content = [Content]()
        content.append(Content(title: "Story/s", number: 2))
        return content
    }()
    var approvalNeeded = false
    var managerFee = false
    var files = [String]()
    
    var cfid: String!
    var collabKey: String?
    var collab: Collab?
    
    var platformHeight: NSLayoutConstraint!
    var contentButtonHeight: NSLayoutConstraint!
    var tableHeight: NSLayoutConstraint!
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(titleField)
        contenView.addSubview(collabTextView)
        contenView.addSubview(fieldsView)
        
        fieldsView.addSubview(deadlinePicker)
        fieldsView.addSubview(brandField)
        fieldsView.addSubview(revardField)
        fieldsView.addSubview(platformButton)
        fieldsView.addSubview(contentButton)
        fieldsView.addSubview(deadlineLabel)
        fieldsView.addSubview(brandLabel)
        fieldsView.addSubview(revardLabel)
        fieldsView.addSubview(platformLabel)
        fieldsView.addSubview(contentLabel)
        
        contenView.addSubview(contentSwitch)
        contenView.addSubview(feeSwitch)
        contenView.addSubview(feeSwitchLabel)
        contenView.addSubview(contentSwitchLabel)
        
        
        contenView.addSubview(filesLabel)
        contenView.addSubview(menuTableView)
        contenView.addSubview(addButton)
        
        platformHeight = platformButton.heightAnchor.constraint(equalTo: revardField.heightAnchor)
        contentButtonHeight = contentButton.heightAnchor.constraint(equalTo: revardField.heightAnchor)
        tableHeight = menuTableView.heightAnchor.constraint(equalToConstant: 160)
        
        
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
            
            titleField.topAnchor.constraint(equalTo: contenView.topAnchor, constant: 8),
            titleField.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            
            collabTextView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 16),
            collabTextView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            collabTextView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            collabTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            
            fieldsView.topAnchor.constraint(equalTo: collabTextView.bottomAnchor, constant: 28),
            fieldsView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor),
            fieldsView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor),
            
            deadlinePicker.topAnchor.constraint(equalTo: fieldsView.topAnchor, constant: 28),
            deadlinePicker.leadingAnchor.constraint(equalTo: deadlineLabel.trailingAnchor, constant: 16),
            deadlinePicker.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor, constant: -16),
            deadlinePicker.heightAnchor.constraint(equalToConstant: 48),
            
            brandField.topAnchor.constraint(equalTo: deadlinePicker.bottomAnchor, constant: 16),
            brandField.widthAnchor.constraint(equalTo: deadlinePicker.widthAnchor),
            brandField.trailingAnchor.constraint(equalTo: fieldsView.trailingAnchor, constant: -16),
            brandField.heightAnchor.constraint(equalTo: deadlinePicker.heightAnchor),
            
            revardField.topAnchor.constraint(equalTo: brandField.bottomAnchor, constant: 16),
            revardField.trailingAnchor.constraint(equalTo: brandField.trailingAnchor),
            revardField.widthAnchor.constraint(equalTo: brandField.widthAnchor),
            revardField.heightAnchor.constraint(equalTo: brandField.heightAnchor),
            
            platformButton.topAnchor.constraint(equalTo: revardField.bottomAnchor, constant: 16),
            platformButton.trailingAnchor.constraint(equalTo: revardField.trailingAnchor),
            platformButton.widthAnchor.constraint(equalTo: revardField.widthAnchor),
            platformHeight!,
       
            contentButton.topAnchor.constraint(equalTo: platformButton.bottomAnchor, constant: 16),
            contentButton.trailingAnchor.constraint(equalTo: platformButton.trailingAnchor),
            contentButton.widthAnchor.constraint(equalTo: platformButton.widthAnchor),
            contentButtonHeight!,
            contentButton.bottomAnchor.constraint(equalTo: fieldsView.bottomAnchor, constant: -32),
            
            deadlineLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 16),
            deadlineLabel.centerYAnchor.constraint(equalTo: deadlinePicker.centerYAnchor),
            
            brandLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 16),
            brandLabel.centerYAnchor.constraint(equalTo: brandField.centerYAnchor),
            
            revardLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 16),
            revardLabel.centerYAnchor.constraint(equalTo: revardField.centerYAnchor),
            
            platformLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 16),
            platformLabel.centerYAnchor.constraint(equalTo: platformButton.centerYAnchor),
            
            contentLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 16),
            contentLabel.centerYAnchor.constraint(equalTo: contentButton.centerYAnchor),
            
            contentSwitch.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            contentSwitch.topAnchor.constraint(equalTo: fieldsView.bottomAnchor, constant: 24),
            contentSwitch.widthAnchor.constraint(equalToConstant: 51),
            contentSwitch.heightAnchor.constraint(equalToConstant: 31),
            
            feeSwitch.topAnchor.constraint(equalTo: contentSwitch.bottomAnchor, constant: 26),
            feeSwitch.trailingAnchor.constraint(equalTo: contentSwitch.trailingAnchor),
            feeSwitch.widthAnchor.constraint(equalToConstant: 51),
            feeSwitch.heightAnchor.constraint(equalToConstant: 31),
            
            contentSwitchLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            contentSwitchLabel.centerYAnchor.constraint(equalTo: contentSwitch.centerYAnchor),
            
            feeSwitchLabel.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            feeSwitchLabel.centerYAnchor.constraint(equalTo: feeSwitch.centerYAnchor),

            filesLabel.topAnchor.constraint(equalTo: feeSwitchLabel.bottomAnchor, constant: 32),
            filesLabel.leadingAnchor.constraint(equalTo: fieldsView.leadingAnchor, constant: 16),
            
            menuTableView.topAnchor.constraint(equalTo: filesLabel.bottomAnchor, constant: 16),
            menuTableView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor),
            tableHeight!,
            
            addButton.topAnchor.constraint(equalTo: menuTableView.bottomAnchor, constant: 16),
            addButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: contenView.trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.bottomAnchor.constraint(equalTo: contenView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
        titleField.delegate = self
        collabTextView.delegate = self
        brandField.delegate = self
        revardField.delegate = self
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonDidTapped(_:)))
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
    
    override func viewDidLayoutSubviews() {
        generateShadow(for: fieldsView)
        generateShadow(for: deadlinePicker)
        generateShadow(for: brandField)
        generateShadow(for: platformButton)
    }
    

    //MARK: - Functions
    
    @objc func datePickerDidChanged(_ sender: UIDatePicker) {
        deadline = sender.date.timeIntervalSince1970
    }
    
    @objc func platformButtonDidTapped(_ sender: UIButton) {
        let vc = SocialMediaSelectorViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        vc.delegate = self
        vc.platforms = self.platforms
      
        self.present(vc, animated: true)
        
    }
    
    @objc func contentButtonDidTapped(_ sender: UIButton) {
        let vc = ContentSelectionViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        vc.delegate = self
        vc.content = self.content
      
        self.present(vc, animated: true)
        
    }
    
    @objc func addFileButtonDidTapped(_ sender: UIButton) {
        let vc = AttachFileViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        vc.delegate = self
       
      
        self.present(vc, animated: true)
        
    }
    
    @objc func saveButtonDidTapped(_ sender: UIButton) {
        saveCollab { success in
            if success {
                self.navigationController?.popViewController(animated: true)
            }
            else {
                let ac = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        }
       
    }
    
    func saveCollab(_ comletion: ((Bool)-> Void)? = nil) {
        if let colTitle = colTitle,
           let revard = revard,
           let note = note,
           let deadline = deadline,
           let brand = brand
        {
            let collab = Collab(colTitle: colTitle, revard: revard, note: note, deadline: deadline, brand: brand, platforms: platforms,content: self.content ,approvalNeeded: approvalNeeded, managerFee: managerFee, files: files)
            DatabaseManager.shared.saveCollab(collab, in: cfid) { collabKey in
                self.collabKey = collabKey
                self.collab = collab
                comletion?(true)
            }
        }
        else {
            comletion?(false)
        }
        
    }
    
    func generateShadow(for view: UIView) {
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
        view.layer.shadowColor = UIColor(red: 0.93, green: 0.938, blue: 0.942, alpha: 1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = .zero
    }
    
    
    
}


// MARK: - Extensions

extension NewCollabViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        
        case self.brandField:
            self.revardField.becomeFirstResponder()
        default:
            self.revardField.resignFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case revardField:
            guard let amountString = textField.text?.currencyInputFormatting() else {return}
            self.revard = amountString

            textField.text = amountString
        case brandField:
            self.brand = brandField.text
        case titleField:
            self.colTitle = titleField.text
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {return true}
        if textField == revardField {
            if let _ = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits){
                return true
            }
            else {return false}
        }
        else {return true}
    }
    
}

extension NewCollabViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.textColor = .black
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add text"
            textView.textColor = .lightGray
        }
        if textView.textColor != .lightGray {
            note = textView.text
        }
        
    }
}

extension NewCollabViewController: AttachFileDelegate {
    func createInvoice() {
        saveCollab { success in
            if success {
                let vc = MyInfoViewController()
                vc.collabKey = self.collabKey
                vc.cfid = self.cfid
                vc.collab = self.collab
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                let ac = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        }
    }
    
    func addDocument() {
        
    }
    
    func addPicture() {
        
    }
    
    
    
    
}

extension NewCollabViewController: SocialMediaDelegate {
    func platformsWereChosen(_ platforms: [String]) {
        self.platforms = platforms
        let platformTitle = platforms.joined(separator: "\n")
        platformButton.titleLabel?.lineBreakMode = .byWordWrapping
        platformButton.setTitle(platformTitle, for: .normal)
        if platforms.count == 5 {
            platformHeight.constant = 75
        }
        else if platforms.count >= 3 {
            platformHeight.constant = 50
        }
        else {
            platformHeight.constant = 0
        }
      
    }
    
}

extension NewCollabViewController: ContentSelectionDelegate {
    func contentWasChosen(_ content: [Content]) {
        self.content = content
        var contentTitle = ""
        var contentCount = 0
        content.forEach { content in
            guard let number = content.number,
                number > 0
            else {return}
            contentTitle.append("\(number) \(content.title) \n")
            contentCount += 1
        }
        contentTitle = contentTitle.trimmingCharacters(in: ["\n"])
        contentButton.titleLabel?.lineBreakMode = .byWordWrapping
        contentButton.setTitle(contentTitle, for: .normal)
        
        if contentCount >= 6 {
            contentButtonHeight.constant = 100
        }
        else if contentCount == 5 {
            contentButtonHeight.constant = 75
        }
        else if contentCount >= 3 {
            contentButtonHeight.constant = 50
        }
        else {
            contentButtonHeight.constant = 0
        }
    }
    
    
}


extension NewCollabViewController: UITableViewDataSource, UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return files.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as? FileTableViewCell else {fatalError("not able to register cell")}
       cell.titleLabel.text = files[indexPath.row]
       if !cell.titleLabel.text!.contains("Invoice") {
           cell.fileImage.image = UIImage(named: "fileOther")
       }
       
       return cell
   }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

   }
}

