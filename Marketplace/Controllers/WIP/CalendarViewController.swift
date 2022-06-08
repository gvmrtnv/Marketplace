//
//  CalendarViewController.swift
//  Influencer
//
//  Created by Gleb Martynov on 27.01.22.
//

import UIKit

class CalendarViewController: UIViewController {
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    } ()
    
    private lazy var headerView = HeaderCalendarView ()

    private lazy var footerView = FooterCalendarView(
        didTapLastMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }
            self.selectedDate = self.calendar.date(byAdding: .month, value: -1, to: self.selectedDate) ?? self.selectedDate
        },
        didTapNextMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }
            self.selectedDate = self.calendar.date(byAdding: .month, value: 1, to: self.selectedDate) ?? self.selectedDate
        }
    )
    
    private lazy var taskTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var newNoteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .opaqueSeparator
        button.setTitle("New note", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(didTapNewNote), for: .touchUpInside)
        return button
    }()

    // MARK: - Calendar Data Values
    
    private let calendar = Calendar(identifier: .gregorian)
    private var selectedDate = Date.now {
        didSet {
            days = generateDaysInMonth(for: selectedDate)
            collectionView.reloadData()
            headerView.baseDate = selectedDate
            dayTasksUpdate()
            taskTableView.reloadData()
        }
    }
    private lazy var dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "d"
      return dateFormatter
    }()
    private lazy var days = generateDaysInMonth(for: selectedDate)
    private var numberOfWeeksInBaseDate: Int {
      calendar.range(of: .weekOfMonth, in: .month, for: selectedDate)?.count ?? 0
    }
    
    // MARK: - Task Values
    
    var tasks: [Collab]?
    var dayTasks: [Collab]?
    
    private func dayTasksUpdate () {
        dayTasks = tasks?.filter({ task in
            let taskDate = Date(timeIntervalSince1970: task.deadline)
            let taskDay = calendar.component(.day, from: taskDate)
            let selectedDay = calendar.component(.day, from: selectedDate)
            return taskDay == selectedDay
        })
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.addSubview(headerView)
        view.addSubview(collectionView)
        view.addSubview(footerView)
        view.addSubview(taskTableView)
        view.addSubview(newNoteButton)
        view.backgroundColor = .white
       
        
        
        let constraints = [
            
            headerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 85),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            footerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            footerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 60),
            
            taskTableView.topAnchor.constraint(equalTo: footerView.bottomAnchor),
            taskTableView.bottomAnchor.constraint(equalTo: newNoteButton.topAnchor),
            taskTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            newNoteButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            newNoteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            newNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            newNoteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        headerView.baseDate = selectedDate
        
        collectionView.register(CalendarDateCollectionViewCell.self, forCellWithReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: "taskCell")
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
    
//        DatabaseManager.shared.getUserCollabs { tasks in
//            self.tasks = tasks
//            self.dayTasksUpdate()
//            self.taskTableView.reloadData()
//        }
        
    }
    
    @objc func didTapNewNote () {
        print("bubton")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "newCollabView") as? NewCollabViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
  
    
   
}


// MARK: - Day Generation

private extension CalendarViewController {
   
    func monthMetadata(for baseDate: Date) -> MonthMetadata {
        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            fatalError("MonthMetadata error")
        }
        let firstDayWeekDay = calendar.component(.weekday, from: firstDayOfMonth)
        return MonthMetadata(numberOfDays: numberOfDaysInMonth, firstDay: firstDayOfMonth, firstDayWeekday: firstDayWeekDay)
        
    }
    
    func generateDaysInMonth(for baseDate: Date) -> [Day] {
      let metadata = monthMetadata(for: baseDate)
      let numberOfDaysInMonth = metadata.numberOfDays
      let offsetInInitialRow = metadata.firstDayWeekday
      let firstDayOfMonth = metadata.firstDay

      var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow)).map { day in
          let isWithinDisplayedMonth = day >= offsetInInitialRow
          let dayOffset = isWithinDisplayedMonth ? day - offsetInInitialRow : -(offsetInInitialRow - day)
          
          return generateDay(offsetBy: dayOffset, for: firstDayOfMonth, isWithinDisplayedMonth: isWithinDisplayedMonth)
      }
      days += generateStartOfNextMonth(using: firstDayOfMonth)
      return days
    }

    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
      let date = calendar.date(byAdding: .day, value: dayOffset,to: baseDate) ?? baseDate
      return Day(date: date,number: dateFormatter.string(from: date), isSelected: calendar.isDate(date, inSameDayAs: selectedDate),isWithinDisplayedMonth: isWithinDisplayedMonth)
    }
    
    func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date) -> [Day] {
      guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1),to: firstDayOfDisplayedMonth) else {return []}
      let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
      guard additionalDays > 0 else {return []}
        let days: [Day] = (1...additionalDays).map {
        generateDay(offsetBy: $0,for: lastDayInMonth, isWithinDisplayedMonth: false)
        }
        return days
    }
}

// MARK: - UICollectionViewDataSource
extension CalendarViewController: UICollectionViewDataSource {
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      days.count
    }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let day = days[indexPath.row]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier, for: indexPath) as! CalendarDateCollectionViewCell
    cell.day = day
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let day = days[indexPath.row]
    selectedDate = day.date
  }
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = Int(collectionView.frame.width / 7)
    let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
    return CGSize(width: width, height: height)
  }
}

// MARK: - Table View
extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayTasks?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasks![indexPath.row].colTitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "collabView") as? CollabViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
}
