//
//  InvoiceTabViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 06.03.22.
//

import UIKit
import PDFKit

class InvoiceTabViewController: UIViewController {
    
    //MARK: - Views
    
  
    private lazy var titleLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Invoices"
        label.font = .boldSystemFont(ofSize: 30)
        
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
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create invoice", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(createButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Values
    
    var invoices = [FireInvoice]() {
        didSet {
            
          
//            menuTableView.reloadData()
        }
    }
    
    var constraints = [NSLayoutConstraint]()
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            menuTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            createButton.topAnchor.constraint(greaterThanOrEqualTo: menuTableView.bottomAnchor, constant: 16),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ]
        DatabaseManager.shared.getUserInvoices { invoices in
            self.invoices = invoices
            self.setUpViewWithData()
        }
       

    }
    

    func setUpViewWithData() {
        view.addSubview(titleLabel)
        view.addSubview(menuTableView)
        view.addSubview(createButton)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        NSLayoutConstraint.activate(constraints)

    }
    
    
    
    @objc func createButtonDidTapped(_ sender: Any) {
        let vc = PreviewInvoiceViewController()
        
        DatabaseManager.shared.getUserLists { colFol in
            let colFol1 = colFol.first!
            let col = colFol1.collabs?.first
            let invoice = Invoice(collab: col!, myName: "wsew", myLastName: "wer", myCompanyName: "wewer", myAddress: "wewer", myTaxNumber: "wewer", myAccountHolder: "wewer", myIban: "wewer", myBankName: "wewer", recName: "wewer", recLastName: "wewer", recCompanyName: "wewer", recAddress: "wewer", recTaxNumber: "wewer", service: "wewer", compensation: "wewer", taxPercent: "wewer", brand: "wewer", invoiceNumber: "wewer", date: 1646661540)
            vc.invoice = invoice
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


extension InvoiceTabViewController: UITableViewDataSource, UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return invoices.count
  
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as? FileTableViewCell else {fatalError("not able to register cell")}
       cell.titleLabel.text = invoices[indexPath.row].title
    
       return cell
   }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let url = invoices[indexPath.row].url
       let task = URLSession.shared.downloadTask(with: url) { localUrl, _, error in
           guard error == nil,
                 let localUrl = localUrl
           else {
               print(error!.localizedDescription)
               return
           }
           
           if let document = PDFDocument(url: localUrl) {
               DispatchQueue.main.async {
                   let vc = PdfViewController()
                   vc.pdfTitle = self.invoices[indexPath.row].title
                   vc.document = document
                   self.navigationController?.pushViewController(vc, animated: true)
               }
               
           }
           
           let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
           let pathComponents = url.pathComponents.last!
           let destinationUrl = documentsPath.appendingPathComponent(pathComponents)
           try? FileManager.default.removeItem(at: destinationUrl)
           do {
               try FileManager.default.copyItem(at: localUrl, to: destinationUrl)
               
            
           } catch let error {
               print(error.localizedDescription)
           }
       }
       task.resume()


   }
}
