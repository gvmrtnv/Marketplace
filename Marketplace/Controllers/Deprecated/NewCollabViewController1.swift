//
//  NewCollabViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 26.01.22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class NewCollabViewController1: UIViewController {
    
    @IBOutlet var menuTableView: UITableView!
    @IBOutlet var collabTitle: UITextField!
    @IBOutlet var collabNote: UITextView!
    
    var deadline: TimeInterval?
    var revard: String?
    
    let data = ["Deadline:", "Brand:", "Revard:", "Platform:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveDidTap))
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    @objc func saveDidTap (){
        guard let deadline = deadline,
              let revard = revard,
              let title = collabTitle.text,
              let note = collabNote.text
        else {return}
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        let database = Database.database().reference()
        guard let collabKey = database.child("/lists/\(userID)/collabs").childByAutoId().key else {return}
        let update = ["/lists/\(userID)/collabs/\(collabKey)/deadline": deadline,
                      "/lists/\(userID)/collabs/\(collabKey)/revard": revard,
                      "/lists/\(userID)/collabs/\(collabKey)/title": title,
                      "/lists/\(userID)/collabs/\(collabKey)/note": note
        ] as [String : Any]
        database.updateChildValues(update)
    }
    
    
    
}
extension NewCollabViewController1: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == IndexPath(row: 1, section: 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "date", for: IndexPath(row: 1, section: 0)) as? DateTableViewCell else {
                fatalError("Unable to dequeue DateCell")
            }
            cell.dateTime.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "revard", for: IndexPath(row: 2, section: 0)) as? ValueTableViewCell
            else {
                fatalError("Unable to dequeue RevardCell")
            }
            cell.cellValue.delegate = self
            
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func datePickerChanged (_ sender:UIDatePicker) {
        deadline = sender.date.timeIntervalSince1970
    }
}
extension NewCollabViewController1: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.placeholder {
        case "Amount":
            guard let text = textField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {return}
            self.revard = text
        default:
            break
        }
    }
}



