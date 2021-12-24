import UIKit

class HabitDetailsViewController: UIViewController {
    fileprivate let forCellReuseIdentifier = "habitDate"
    
    let habitDatesTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
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
        let viewControllerNext = AddEditHabitViewController()
        viewControllerNext.view.backgroundColor = ColorKit.commonBackgroundColor
        
        navigationController?.pushViewController(viewControllerNext, animated: true)
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Сегодня"
        
        return cell
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
