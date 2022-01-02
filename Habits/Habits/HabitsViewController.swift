import UIKit

class HabitsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate var store: HabitsStore
    
    var progressCellId = "ProgressCell"
    var habitCellId = "HabitCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = ColorKit.commonBackgroundColor
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    public init() {
        self.store = HabitsStore.shared
        super.init(nibName: nil, bundle: nil)
        
        let infoButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus")?.withTintColor(.purple, renderingMode: .alwaysOriginal),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(addHabit)
        )
        navigationItem.rightBarButtonItem = infoButtonItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorKit.commonBackgroundColor
        self.navigationItem.title = "Сегодня"
        
        view.addSubview(collectionView)

        activateConstraints([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        registerCells()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification) {
      self.collectionView.reloadData()
    }
    
    fileprivate func registerCells() {
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: progressCellId)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: habitCellId)
    }
    
    @objc private func addHabit() {
        let newHabit = Habit(
            name: "",
            date: Date(),
            color: ColorKit.systemPurple
        )
        let viewControllerNext = AddEditHabitViewController(newHabit, AddEditHabitViewMode.createMode)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(viewControllerNext, animated: false)
    }
    
    @objc private func trackHabit(sender: Any) {
        let checkMarkViewTap = sender as! CheckMarkViewTap
        let habit = checkMarkViewTap.habit!
        
        let store = HabitsStore.shared
        store.track(habit)
        NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.store.habits.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: progressCellId, for: indexPath) as! ProgressCollectionViewCell
            progressCell.setProgressValue(store.todayProgress)
            return progressCell
        }
        else
        {
            let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: habitCellId, for: indexPath) as! HabitCollectionViewCell
            let habit = self.store.habits[indexPath.item-1]
            
            habitCell.setName(habit.name)
            habitCell.setBaseColor(habit.color)
            habitCell.setScheduleTime(habit.date)
            habitCell.setViewsCounter(habit.trackDates.count)
            
            //checkMarkView
            habitCell.toggleHabitDone(habit.isAlreadyTakenToday)
            let tapGesture = CheckMarkViewTap(target: self, action: #selector(trackHabit(sender:)))
            tapGesture.habit = habit
            if habit.isAlreadyTakenToday == false {
                habitCell.checkMarkView.isUserInteractionEnabled = true
                habitCell.checkMarkView.addGestureRecognizer(tapGesture)
            } else {
                habitCell.checkMarkView.isUserInteractionEnabled = false
                habitCell.checkMarkView.removeGestureRecognizer(tapGesture)
            }
            
            return habitCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: Int(view.frame.width) - 2*ViewConstants.padding, height: 60)
        }
        return CGSize(width: Int(view.frame.width) - 2*ViewConstants.padding, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(ViewConstants.smallPadding)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(ViewConstants.wrapPadding), left: CGFloat(ViewConstants.padding), bottom: CGFloat(ViewConstants.wrapPadding), right: CGFloat(ViewConstants.padding))
    }

}

extension HabitsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let habit = self.store.habits[indexPath.item-1]
    let viewControllerNext = HabitDetailsViewController(habit)
    viewControllerNext.view.backgroundColor = ColorKit.commonBackgroundColor
    
    navigationController?.pushViewController(viewControllerNext, animated: true)
  }
}

class CheckMarkViewTap: UITapGestureRecognizer {
  var habit: Habit?
}
