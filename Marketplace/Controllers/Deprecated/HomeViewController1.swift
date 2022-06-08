////
////  ViewController.swift
////  Influencer
////
////  Created by Gleb Martynov on 16.01.22.
////
//
//import FirebaseAuth
//import UIKit
//
//class HomeViewController1: UIViewController {
//    
//    @IBOutlet var menuTableView: UITableView!
//    @IBOutlet var tasksTableView: UITableView!
//    
//    @IBOutlet var tasksTableViewHeight: NSLayoutConstraint!
//    
//    var collabs: [Collab]?
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        menuTableView.dataSource = self
//        menuTableView.delegate = self
//        tasksTableView.dataSource = self
//        tasksTableView.delegate = self
////        DatabaseManager.shared.getUserCollabs { collabs in
////                self.collabs = collabs
////                self.tasksTableView.reloadData()
////                self.tasksTableViewHeight.constant = self.tasksTableView.contentSize.height
////        }
//    }
//        
//    override func viewDidLayoutSubviews() {
//        menuTableView.constraints.first?.constant = menuTableView.contentSize.height
//        tasksTableViewHeight.constant = tasksTableView.contentSize.height
//    }
//    
//    
//    @IBAction func calendarDidTapped(_ sender: Any) {
//        let vc = CalendarViewController()
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    
//}
//
//extension HomeViewController1: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == self.tasksTableView {
//            guard let collabs = collabs else {return 0}
//            if collabs.count > 3 {return 3}
//            else {return collabs.count}
//        }
//        else {
//            return 3
//        }
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == self.menuTableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath)
//            return cell
//        }
//        else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath)
//            cell.textLabel?.text = collabs![indexPath.row].colTitle
//            return cell
//        }
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView == self.menuTableView {
//            guard let vc = storyboard?.instantiateViewController(withIdentifier: "collabsView") as? CollabsViewController else {return}
//            navigationController?.pushViewController(vc, animated: true)
//            
//        }
//
//        
//    }
//}
