import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        label.text = "Всё получится!"
        return label
    }()
    
    private let progressPercentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        label.text = "0%"
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0
        progressView.progressTintColor = .purple
        progressView.layer.cornerRadius = 3.5
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        mainView.addSubviews([
            titleLabel,
            progressPercentLabel,
            progressView
        ])
        contentView.addSubviews([
            mainView
        ])
        contentView.activateConstraints([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(ViewConstants.smallPadding)),
            progressPercentLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            progressPercentLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: CGFloat(-1*ViewConstants.smallPadding)),
            progressView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(ViewConstants.smallPadding)),
            progressView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: CGFloat(-1*ViewConstants.smallPadding)),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setProgressValue(_ value: Float) {
        progressView.progress = value
        progressPercentLabel.text = "\(Int(value*100))%"
    }
}
