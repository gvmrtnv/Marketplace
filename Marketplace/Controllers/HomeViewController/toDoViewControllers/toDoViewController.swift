//
//  toDoViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 23.02.22.
//

import UIKit

class toDoViewController: UIViewController {
    
    
    // MARK: - Views
    
    
    
    private lazy var collabsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Orders"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private var tasksTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(HomeEventTableViewCell.self, forCellReuseIdentifier: "task")
        view.rowHeight = 80
        view.estimatedRowHeight = 80
        view.separatorStyle = .none
        return view
    }()
    
    
    private lazy var newCollabButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New note", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(createCollabButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()

    
    // MARK: - Values
    
    var collabFolder: CollabFolder! {
        didSet {
            if let collab = collabFolder.collabs {
                
                self.collabs = collab
            }
            tasksTableView.reloadData()
        }
    }
    var collabs = [Collab]()
    var cfid: String!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "To-Do List"
        
        DatabaseManager.shared.getUserCollabFolder(withId: cfid, completion: { newCF in
            self.collabFolder = newCF
        })
        
        view.addSubview(collabsLabel)
        view.addSubview(tasksTableView)
        view.addSubview(newCollabButton)
        
        let constraints = [
        
            collabsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            collabsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tasksTableView.topAnchor.constraint(equalTo: collabsLabel.bottomAnchor, constant: 16),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            newCollabButton.topAnchor.constraint(equalTo: tasksTableView.bottomAnchor, constant: 8),
            newCollabButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            newCollabButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            newCollabButton.heightAnchor.constraint(equalToConstant: 50),
            newCollabButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
        
        
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        
    }
 


    // MARK: - Functions

    @objc func createCollabButtonDidTapped(_ sender: UIButton) {
        let vc = NewCollabViewController()
        vc.cfid = cfid
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - Extensions

extension toDoViewController: UITableViewDataSource, UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return collabs.count
  
   
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as? HomeEventTableViewCell else {fatalError("not able to register cell")}
           cell.titleLabel.text = collabs[indexPath.row].colTitle
           let date =  Date(timeIntervalSince1970: collabs[indexPath.row].deadline)
           let formatter = DateFormatter()
           formatter.dateFormat = "E, d MMM"
        
           cell.dateLabel.text = formatter.string(from: date)
           return cell

   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
           
       
   }
}
