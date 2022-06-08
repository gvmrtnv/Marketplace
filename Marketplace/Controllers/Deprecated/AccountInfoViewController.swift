//
//  AccountInfoViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 21.01.22.
//

import UIKit
import FirebaseAuth
import Kingfisher

class AccountInfoViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var secondName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var bio: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapDone))
        DatabaseManager.shared.getUserDataOnce { user in
            self.name.text = user.name
            self.secondName.text = user.secondName
            self.userName.text = user.username
            self.region.text = user.region
            
            if let url = user.profilePhoto {
                self.image.kf.setImage(
                    with: url,
                    placeholder: UIImage(systemName: "person.crop.circle.badge.questionmark"), completionHandler: {_, error, _, _ in
                        if let error = error {
                            print(error.localizedDescription)
                            print("picture")
                        }
                    })
            }
        }
    }
    
     
    @IBAction func didTapPicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func didTapDone () {
        guard let name = name.text, name.count >= 2,
              let secondName = secondName.text, secondName.count >= 2,
              let userName = userName.text, userName.count >= 2,
              let region = region.text, region.count >= 2,
              let bio = bio.text, bio.count >= 2
        else {return}
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let update = ["/users/\(userID)/name": name,
                      "/users/\(userID)/secondname": secondName,
                      "/users/\(userID)/username": userName,
                      "/users/\(userID)/region": region,
                      "/users/\(userID)/bio": bio]
        DatabaseManager.shared.updateUserData(with: update)
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    @objc func didTapCancel () {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
}
extension AccountInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        self.image.image = image
        dismiss(animated: true)
        StorageManager.shared.uploadUserFoto(image)
    }
    
}
