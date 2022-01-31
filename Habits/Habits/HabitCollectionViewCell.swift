import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    private var baseColor: UIColor = UIColor.black
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontKit.headline ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        
        label.text = ""
        return label
    }()
    
    private let descriptionView: UILabel = {
        let label = UILabel()
        label.textColor = ColorKit.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = FontKit.caption ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        
        label.text = ""
        return label
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorKit.systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontKit.footnoteCell ?? UIFont.systemFont(ofSize: 13, weight: .regular)
        
        label.text = "Счётчик: 0"
        return label
    }()
    
    public let checkMarkView: CheckMarkView = {
        let view = CheckMarkView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setBaseColor(self.baseColor)
        mainView.addSubviews([
            checkMarkView,
            titleLabel,
            descriptionView,
            counterLabel
        ])
        contentView.addSubviews([
            mainView
        ])
        contentView.activateConstraints([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            checkMarkView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -25),
            checkMarkView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            checkMarkView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: CGFloat(ViewConstants.largePadding)),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(ViewConstants.largePadding)),
            titleLabel.trailingAnchor.constraint(equalTo: checkMarkView.leadingAnchor, constant: -40),
            descriptionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(ViewConstants.largePadding)),
            descriptionView.trailingAnchor.constraint(equalTo: checkMarkView.leadingAnchor, constant: -40),
            counterLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(ViewConstants.largePadding)),
            counterLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: CGFloat(-1*ViewConstants.largePadding)),
            counterLabel.trailingAnchor.constraint(equalTo: checkMarkView.leadingAnchor, constant: -40),
        ])
    }

    
    public func setName(_ name: String) {
        titleLabel.text = name
    }
    
    public func setScheduleTime(_ time: Date) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        let strDate = timeFormatter.string(from: time)
        descriptionView.text = "Каждый день в \(strDate)"
    }
    
    public func setBaseColor(_ baseColor: UIColor) {
        self.baseColor = baseColor
        titleLabel.textColor = self.baseColor
        checkMarkView.setBaseColor(self.baseColor)
    }
    
    public func setViewsCounter(_ counter: Int) {
        
        counterLabel.text = "Счётчик: \(counter)"
    }
    
    public func toggleHabitDone(_ isDone: Bool) {
        checkMarkView.toggleChecked(isDone)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
