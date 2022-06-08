//
//  CollabsViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 26.01.22.
//

import UIKit

class CollabsViewController: UIViewController {
    
    @IBOutlet var tasksTableView: UITableView!
    var collabs: [Collab]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
//        DatabaseManager.shared.getUserCollabs { collabs in
//            self.collabs = collabs
//            self.tasksTableView.reloadData()
//        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        DispatchQueue.main.async {
//
//        }
//    }
    
    
    
    @IBAction func newNoteDidTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "newCollabView") as? NewCollabViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
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

extension CollabsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collabs?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath)
        cell.textLabel?.text = collabs![indexPath.row].colTitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "collabView") as? CollabViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
}
