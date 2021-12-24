import UIKit

class CheckMarkView: UIView {
    private let checkmarkImageSize = 38
    private let curcleCheckmarkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        return view
    }()
    
    private let temporaryCheckMark: UIImageView = {
        let image = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = image
        return logoImageView
    }()
    
    private var isChecked = false
    private var baseColor: UIColor = UIColor.purple
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBaseColor(baseColor)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        curcleCheckmarkView.layer.borderColor = self.baseColor.cgColor
        
        curcleCheckmarkView.layer.cornerRadius = CGFloat(checkmarkImageSize/2)
        curcleCheckmarkView.addSubview(temporaryCheckMark)
        addSubview(curcleCheckmarkView)
        activateConstraints([
            curcleCheckmarkView.widthAnchor.constraint(equalToConstant: CGFloat(checkmarkImageSize)),
            curcleCheckmarkView.heightAnchor.constraint(equalToConstant: CGFloat(checkmarkImageSize)),
            curcleCheckmarkView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            curcleCheckmarkView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            curcleCheckmarkView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            temporaryCheckMark.centerYAnchor.constraint(equalTo: curcleCheckmarkView.centerYAnchor),
            temporaryCheckMark.centerXAnchor.constraint(equalTo: curcleCheckmarkView.centerXAnchor),
        ])
    }
    
    public func setBaseColor(_ baseColor: UIColor) {
        self.baseColor = baseColor
        curcleCheckmarkView.layer.borderColor = self.baseColor.cgColor
    }
    
    public func toggleChecked(_ isChecked: Bool) {
        if isChecked {
            curcleCheckmarkView.backgroundColor = self.baseColor
        } else {
            curcleCheckmarkView.backgroundColor = UIColor.white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
