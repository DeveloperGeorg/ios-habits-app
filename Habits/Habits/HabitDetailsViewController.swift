import UIKit

class HabitDetailsViewController: UIViewController {
    fileprivate let forCellReuseIdentifier = "habitDate"
    
    let habitDatesTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    fileprivate var habit: Habit
    
    public init(_ habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = habit.name
        self.view.backgroundColor = ColorKit.commonBackgroundColor
        navigationItem.largeTitleDisplayMode = .never
        
        let backButton = UIBarButtonItem()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let editButtonItem = UIBarButtonItem(
            title: "Править",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(editHabitAction)
        )
        navigationItem.rightBarButtonItem = editButtonItem
        
        
        view.addSubview(habitDatesTableView)
        
        habitDatesTableView.dataSource = self
        habitDatesTableView.delegate = self
        habitDatesTableView.rowHeight = UITableView.automaticDimension
        
        habitDatesTableView.register(UITableViewCell.self, forCellReuseIdentifier: forCellReuseIdentifier)

        activateConstraints([
            habitDatesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitDatesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitDatesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitDatesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 250
        }
    
    @objc private func editHabitAction() {
        let viewControllerNext = AddEditHabitViewController(self.habit)
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        
        navigationController?.pushViewController(viewControllerNext, animated: false)
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forCellReuseIdentifier, for: indexPath)
        var trackDates = HabitsStore.shared.dates
        trackDates.reverse()
        let date = trackDates[indexPath.item]
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .none
        timeFormatter.dateStyle = .medium
        timeFormatter.locale = Locale.current
        timeFormatter.doesRelativeDateFormatting = true
        cell.textLabel?.text = timeFormatter.string(from: date)
        
        if(HabitsStore.shared.habit(habit, isTrackedIn: date)) {
            cell.accessoryType = .checkmark
            cell.tintColor = ColorKit.systemPurple
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
