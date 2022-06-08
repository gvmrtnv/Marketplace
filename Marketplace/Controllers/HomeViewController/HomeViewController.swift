//
//  HomeViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 16.02.22.
//

import UIKit
import Kingfisher
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
    

    
    // MARK: - Views for no Data
    
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
    
    private var profileButton: ProfileButton = {
        let button = ProfileButton()
        DatabaseManager.shared.getUserDataOnce { user in
            button.helloLabel.text = "Hello \(user.name)!"
            
            if let url = user.profilePhoto {
                button.profileImage.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "emptyAvatar"), completionHandler: {_, error, _, _ in
                        if let error = error {
                            print(error.localizedDescription)
                           
                        }
                    })
            }
        }
        
        button.addTarget(self, action: #selector(profileButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var toDoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
      
        
        return view
    }()
    
    private lazy var toDoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To-Do Lists"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var toDoImage: UIImageView = {
        let image = UIImage(named: "toDo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var createNotesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create notes with tasks, add files, share lists\nand manage your orders"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var newNoteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New note", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .white
        button.layer.cornerRadius = 14
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        
  
        return button
    }()
    
    private lazy var newListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New list", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(createListButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var statView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private lazy var statLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Statistics"
        label.font = .boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    private lazy var statImage: UIImageView = {
        let image = UIImage(named: "stat")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var noDataYetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No data yet.\nThe stats from your notes appears here."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Views with Data
    private lazy var newListPlusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12

        let image = UIImage(named: "cross")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(createListButtonDidTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        
        let image = UIImage(named: "calendar")
        button.setImage(image, for: .normal)
        
        
        return button
    }()
    
    private lazy var calendarLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Calendar"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var newListLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New List"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private lazy var nextEventsLabel: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Next Events"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private var menuTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(HomeMenuTableViewCell.self, forCellReuseIdentifier: "menu")
        view.rowHeight = 80
        view.estimatedRowHeight = 80
        view.separatorStyle = .none
   
        return view
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
    
    
    
    
    
    // MARK: - Values
    
    
    var lists = [CollabFolder]()  {
        didSet {
            var allCollabs = [Collab]()
            lists.forEach { list in
                if let collabs = list.collabs {
                    allCollabs.append(contentsOf: collabs)
                }
            }
            self.collabs = allCollabs
            
            if oldValue.isEmpty && !lists.isEmpty{
         
                SetUptoDoViewWithData()
            }
            else if lists.isEmpty{
               
                SetUptoDoViewNoData()
            }
            
            menuTableView.reloadData()
            tasksTableView.reloadData()
            
            viewWillLayoutSubviews()
        }
    }
    
    var collabs = [Collab]()
    
    var dataConstraints = [NSLayoutConstraint]()
    var noDataConstraints = [NSLayoutConstraint]()
    var heightConstraints = [NSLayoutConstraint]()
    
    var toDoHeight: NSLayoutConstraint!
    var menuHeight: NSLayoutConstraint!
    var taskHeight: NSLayoutConstraint!

    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DatabaseManager.shared.getUserLists{ lists in
            self.lists = lists
      
        }
        
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contenView)
        contenView.addSubview(profileButton)
        
        contenView.addSubview(toDoView)
        toDoView.addSubview(toDoLabel)
        
        
        contenView.addSubview(statView)
        statView.addSubview(statLabel)
        statView.addSubview(statImage)
        statView.addSubview(noDataYetLabel)
        
//        if !lists.isEmpty {
//            SetUptoDoViewWithData()
//
//        }
//        else {
//            SetUptoDoViewNoData()
//        }
//
        
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
            
            profileButton.topAnchor.constraint(equalTo: contenView.topAnchor, constant: 34),
            profileButton.leadingAnchor.constraint(equalTo: contenView.leadingAnchor, constant: 16),
            profileButton.heightAnchor.constraint(equalToConstant: 48),
            
            toDoView.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 52),
            toDoView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor),
            toDoView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor),
            
            toDoLabel.topAnchor.constraint(equalTo: toDoView.topAnchor),
            toDoLabel.leadingAnchor.constraint(equalTo: toDoView.leadingAnchor, constant: 16),
            
            statView.topAnchor.constraint(equalTo: toDoView.bottomAnchor, constant: 40),
            statView.leadingAnchor.constraint(equalTo: contenView.leadingAnchor),
            statView.trailingAnchor.constraint(equalTo: contenView.trailingAnchor),
            statView.bottomAnchor.constraint(equalTo: contenView.bottomAnchor, constant: -16),
            
            statLabel.topAnchor.constraint(equalTo: statView.topAnchor, constant: 40),
            statLabel.leadingAnchor.constraint(equalTo: statView.leadingAnchor, constant: 16),
            
            statImage.topAnchor.constraint(equalTo: statLabel.bottomAnchor, constant: 40),
            statImage.leadingAnchor.constraint(equalTo: statView.leadingAnchor, constant: 16),
            statImage.trailingAnchor.constraint(equalTo: statView.trailingAnchor, constant: -16),
            statImage.heightAnchor.constraint(equalTo: statImage.widthAnchor, multiplier: 212/343),
            
            noDataYetLabel.topAnchor.constraint(equalTo: statImage.bottomAnchor, constant: 24),
            noDataYetLabel.centerXAnchor.constraint(equalTo: statView.centerXAnchor),
            noDataYetLabel.bottomAnchor.constraint(equalTo: statView.bottomAnchor, constant: -55)
          
        ]
        NSLayoutConstraint.activate(constraints)
        
        dataConstraints = [
            
            menuTableView.topAnchor.constraint(equalTo: toDoLabel.bottomAnchor, constant: 32),
            menuTableView.leadingAnchor.constraint(equalTo: toDoView.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: toDoView.trailingAnchor),
            
            calendarButton.topAnchor.constraint(equalTo: menuTableView.bottomAnchor, constant: 8),
            calendarButton.leadingAnchor.constraint(equalTo: toDoView.leadingAnchor, constant: 16),
            calendarButton.heightAnchor.constraint(equalToConstant: 56),
            calendarButton.widthAnchor.constraint(equalTo: calendarButton.heightAnchor),
            
            newListPlusButton.leadingAnchor.constraint(equalTo: calendarButton.trailingAnchor, constant: 133),
            newListPlusButton.centerYAnchor.constraint(equalTo: calendarButton.centerYAnchor),
            newListPlusButton.heightAnchor.constraint(equalToConstant: 56),
            newListPlusButton.widthAnchor.constraint(equalTo: newListPlusButton.heightAnchor),
            
            calendarLabel.leadingAnchor.constraint(equalTo: calendarButton.trailingAnchor, constant: 16),
            calendarLabel.centerYAnchor.constraint(equalTo: calendarButton.centerYAnchor),
            
            newListLabel.leadingAnchor.constraint(equalTo: newListPlusButton.trailingAnchor, constant: 16),
            newListLabel.centerYAnchor.constraint(equalTo: newListPlusButton.centerYAnchor),
            
            
            nextEventsLabel.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 40),
            nextEventsLabel.leadingAnchor.constraint(equalTo: toDoView.leadingAnchor, constant: 16),
            
            
            tasksTableView.topAnchor.constraint(equalTo: nextEventsLabel.bottomAnchor, constant: 10),
            tasksTableView.leadingAnchor.constraint(equalTo: toDoView.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: toDoView.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: toDoView.bottomAnchor),
            
        ]
        
        toDoHeight = toDoView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        menuHeight = menuTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        taskHeight = tasksTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        
        heightConstraints = [
            toDoHeight!,menuHeight!,taskHeight!]
        
        
        noDataConstraints = [
            
            
            toDoImage.topAnchor.constraint(equalTo: toDoLabel.bottomAnchor, constant: 40),
            toDoImage.leadingAnchor.constraint(equalTo: toDoView.leadingAnchor, constant: 16),
            toDoImage.trailingAnchor.constraint(equalTo: toDoView.trailingAnchor, constant: -16),
            toDoImage.heightAnchor.constraint(equalTo: toDoView.widthAnchor, multiplier: 1),
            
            createNotesLabel.topAnchor.constraint(equalTo: toDoImage.bottomAnchor, constant: 16),
            createNotesLabel.centerXAnchor.constraint(equalTo: toDoView.centerXAnchor),
            
            newNoteButton.topAnchor.constraint(equalTo: createNotesLabel.bottomAnchor, constant: 52),
            newNoteButton.leadingAnchor.constraint(equalTo: toDoView.leadingAnchor, constant: 16),
            newNoteButton.trailingAnchor.constraint(equalTo: toDoView.trailingAnchor, constant: -16),
            newNoteButton.heightAnchor.constraint(equalToConstant: 50),
            
            newListButton.topAnchor.constraint(equalTo: newNoteButton.bottomAnchor, constant: 16),
            newListButton.leadingAnchor.constraint(equalTo: toDoView.leadingAnchor, constant: 16),
            newListButton.trailingAnchor.constraint(equalTo: toDoView.trailingAnchor, constant: -16),
            newListButton.heightAnchor.constraint(equalToConstant: 50),
            newListButton.bottomAnchor.constraint(equalTo: toDoView.bottomAnchor)
            ]
        
       
        
       
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        menuHeight.constant = menuTableView.contentSize.height
        taskHeight.constant = tasksTableView.contentSize.height
        
    }
    
    
    override func viewDidLayoutSubviews() {
        generateShadow(for: statView)
        generateShadow(for: calendarButton)
        generateShadow(for: newListPlusButton)
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
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    




    // MARK: - Functions
    
    func  SetUptoDoViewWithData() {
        toDoImage.removeFromSuperview()
        createNotesLabel.removeFromSuperview()
        newNoteButton.removeFromSuperview()
        newListButton.removeFromSuperview()
        
        
        toDoView.addSubview(menuTableView)
        toDoView.addSubview(newListPlusButton)
        toDoView.addSubview(calendarButton)
        toDoView.addSubview(calendarLabel)
        toDoView.addSubview(newListLabel)
        toDoView.addSubview(nextEventsLabel)
        
        toDoView.addSubview(tasksTableView)
        
        NSLayoutConstraint.activate(dataConstraints)
        NSLayoutConstraint.activate(heightConstraints)
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
    }
    
    func SetUptoDoViewNoData(){
        
        menuTableView.removeFromSuperview()
        newListPlusButton.removeFromSuperview()
        calendarButton.removeFromSuperview()
        calendarLabel.removeFromSuperview()
        newListLabel.removeFromSuperview()
        nextEventsLabel.removeFromSuperview()
        tasksTableView.removeFromSuperview()
        
        toDoView.addSubview(toDoImage)
        toDoView.addSubview(createNotesLabel)
        toDoView.addSubview(newNoteButton)
        toDoView.addSubview(newListButton)
        
        
        NSLayoutConstraint.activate(noDataConstraints)
     
    }
    
    
    @objc func profileButtonDidTapped(_ sender: UIButton){
        let vc = InfluencerAccountInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("button test")
    }

    @objc func createListButtonDidTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: "List Name", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Enter list name"
        }
        ac.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            guard let name = ac.textFields?.first?.text, !name.isEmpty,
            let userID = Auth.auth().currentUser?.uid
            else {return}
            let database = Database.database().reference()
            database.child("/lists/\(userID)").childByAutoId().setValue(["title": name])
        }))
        
        self.present(ac, animated: true)
        menuTableView.reloadData()
        
    }

}

 // MARK: - Extensions

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.menuTableView {
            return lists.count
        }
        else {
            if collabs.count > 3 {return 3}
            else {return collabs.count}
        }
        
    
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.menuTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as? HomeMenuTableViewCell else {fatalError("not able to register cell")}
            cell.titleLabel.text = lists[indexPath.row].title
            
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as? HomeEventTableViewCell else {fatalError("not able to register cell")}
            cell.titleLabel.text = collabs[indexPath.row].colTitle
            let date =  Date(timeIntervalSince1970: collabs[indexPath.row].deadline)
            let formatter = DateFormatter()
            formatter.dateFormat = "E, d MMM"
         
            
            cell.dateLabel.text = formatter.string(from: date)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.menuTableView {
            let vc = toDoViewController()
            let collabFolder = lists[indexPath.row]
            if let collabs = collabFolder.collabs {
                vc.collabs = collabs
            }
            let cfid = collabFolder.cfid
            vc.cfid = cfid
            navigationController?.pushViewController(vc, animated: true)
        }


    }
}
