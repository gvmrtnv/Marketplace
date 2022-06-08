//
//  PersonViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 24.01.22.
//
import FirebaseAuth
import UIKit

class PersonViewController: UIViewController {
    


    @IBOutlet var fullName: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var bio: UILabel!
    @IBOutlet var managerButton: UIButton!
    
    
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let person = person else {return}
        title = person.username
        fullName.text = "\(person.name) \(person.secondName)"
        self.image.kf.setImage(
            with: person.profilePhoto,
            placeholder: UIImage(systemName: "person.crop.circle.badge.questionmark")
        )
        let myId = Auth.auth().currentUser!.uid
        DatabaseManager.shared.getUser(withID: myId){ presentUser in
            if let myManager = presentUser.manager, myManager == person.uid {
                self.managerButton.titleLabel?.text = "Is your manager"
            }
            else if let inRequests = presentUser.inRequests, inRequests[person.uid] == true {
                self.managerButton.titleLabel?.text = "Wants to be your manager"
            }
            else if let outRequests = presentUser.outRequests, outRequests[person.uid] == true {
                self.managerButton.titleLabel?.text = "Waiting for confirmation"
            }
        }
        
    }
        
    
    @IBAction func managerButtonDidTapped(_ sender: Any) {
        if managerButton.titleLabel?.text == "Be my manager!" {
            guard let person = person?.uid else {return}
            DatabaseManager.shared.sendManagerRequest(to: person)
        }
        else if managerButton.titleLabel?.text == "Wants to be your manager" {
            guard let person = person?.uid else {return}
            DatabaseManager.shared.acceptManagerRequest(to: person)
        }
    }
    
    @IBAction func buttonAccept(_ sender: Any) {
        guard let person = person?.uid else {return}
        DatabaseManager.shared.acceptManagerRequest(to: person)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
