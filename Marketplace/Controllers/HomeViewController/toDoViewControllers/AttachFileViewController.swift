//
//  attachFileViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 28.02.22.
//

import UIKit

class AttachFileViewController: UIViewController {

    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Attach file"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(pointSize: 29)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: config)
        
    
        view.setImage(image, for: .normal)
        view.tintColor = UIColor(red: 0.89, green: 0.89, blue: 0.90, alpha: 1.00)
        view.backgroundColor = UIColor(red: 0.51, green: 0.55, blue: 0.60, alpha: 1.00)
        view.layer.cornerRadius = 14.5
        view.addTarget(self, action: #selector(closeDidTapped(_:)), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.73, green: 0.76, blue: 0.76, alpha: 1.00)
        
        
        return view
    }()
    
    private var menuTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "menu")
        view.rowHeight = 51
        view.estimatedRowHeight = 51
        view.layer.cornerRadius = 14
        view.isScrollEnabled = false
        
        return view
    }()
    
    
    
    // MARK: - Values
    
    let labels = ["Create invoice", "Add document", "Add picture"]
    weak var delegate: AttachFileDelegate?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        view.layer.cornerRadius = 14
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(separator)
        view.addSubview(menuTableView)
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 26),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            closeButton.heightAnchor.constraint(equalToConstant: 29),
            closeButton.widthAnchor.constraint(equalToConstant: 29),
            
            separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 29),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            menuTableView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            menuTableView.heightAnchor.constraint(equalToConstant: 153)
        
        ]
        NSLayoutConstraint.activate(constraints)
        
        
        menuTableView.delegate = self
        menuTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - Functions
    
    @objc func closeDidTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }

}



extension AttachFileViewController: UITableViewDataSource, UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return labels.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath)
       cell.textLabel!.text = labels[indexPath.row]
       cell.textLabel!.font = .systemFont(ofSize: 16)
       cell.textLabel!.textColor = UIColor(red: 0.347, green: 0.347, blue: 0.347, alpha: 1)
       
       return cell
   }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       switch indexPath.row {
       case 0:
           createInvoice()
       case 1:
           addDocument()
       default:
           addPicture()
       }


   }


    private func createInvoice () {
        self.dismiss(animated: true) {
            self.delegate?.createInvoice()
        }
        
    }

    private func addDocument () {
        self.dismiss(animated: true) {
            self.delegate?.addDocument()
        }
        
    }

    private func addPicture () {
        self.dismiss(animated: true) {
            self.delegate?.addPicture()
        }
        
    }
}
protocol AttachFileDelegate: AnyObject {
    func createInvoice()
    func addDocument()
    func addPicture()
}
