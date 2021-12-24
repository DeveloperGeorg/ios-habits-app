import UIKit

class HabitsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    }
    
    var progressCellId = "ProgressCell"
    var habitCellId = "HabitCell"

    fileprivate func registerCells() {
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: progressCellId)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: habitCellId)
    }
    
    @objc private func addHabit() {
        let viewControllerNext = AddEditHabitViewController()
        
        navigationController?.pushViewController(viewControllerNext, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: progressCellId, for: indexPath) as! ProgressCollectionViewCell
            return progressCell
        }
        else
        {
            let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: habitCellId, for: indexPath) as! HabitCollectionViewCell
            
            var color: UIColor = UIColor.black
            switch (indexPath.item+1) % 4 {
                case 0:
                    color = HabitsColor.blue
                case 1:
                    color = HabitsColor.green
                case 2:
                    color = HabitsColor.purple
                case 3:
                    color = HabitsColor.orange
                default:
                    color = UIColor.black
            }
            habitCell.setBaseColor(color)
            habitCell.toggleHabitDone(Bool.random())
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
    let viewControllerNext = HabitDetailsViewController()
    viewControllerNext.view.backgroundColor = ColorKit.commonBackgroundColor
    viewControllerNext.title = "Сделать зарядку"
    
    navigationController?.pushViewController(viewControllerNext, animated: true)
  }
}
