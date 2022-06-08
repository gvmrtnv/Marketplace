//
//  ProfileViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 18.01.22.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton))

    }
    @objc func didTapSettingsButton () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SettingsView") as? SettingsViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
