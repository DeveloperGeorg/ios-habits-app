import UIKit

class InfoView: UIView {
    private let infoTitle: String = "Привычка за 21 день"
    private let introduceText = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:"
    private let stages: [String] = [
        "Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.",
        "Выдержать 2 дня в прежнем состоянии самоконтроля.",
        "Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.",
        "Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.",
        "Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.",
        "На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся."
    ]
    private let footnote: String = "Источник: psychbook.ru"

    private let fontSize = 17
    let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()

    let contentView:UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private var paragraphsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = CGFloat(ViewConstants.smallPadding)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        let infoTitleLabelHeight = 24
        let infoTitleLabelTopPadding = 44
        let infoTitleLabel = UILabel()
        infoTitleLabel.text = infoTitle
        infoTitleLabel.textColor = .black
        infoTitleLabel.font = FontKit.title3 ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        infoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let introduceTextTextView = getSimpleTextView(FontKit.body ?? UIFont.systemFont(ofSize: CGFloat(fontSize), weight: .regular))
        introduceTextTextView.text = introduceText
        
        paragraphsStackView.addArrangedSubview(introduceTextTextView)
        stages.enumerated().forEach({
            let textView = getSimpleTextView(FontKit.body ?? UIFont.systemFont(ofSize: CGFloat(fontSize), weight: .regular))
            textView.text = "\(Int($0)+1). \($1)"
            paragraphsStackView.addArrangedSubview(textView)
        })
        
        let footnoteTextView = getSimpleTextView(FontKit.body ?? UIFont.systemFont(ofSize: CGFloat(fontSize), weight: .regular))
        footnoteTextView.text = footnote
        
        paragraphsStackView.addArrangedSubview(footnoteTextView)
        
        contentView.addSubviews([
            infoTitleLabel,
            paragraphsStackView
        ])
        scrollView.addSubviews([contentView])
        addSubviews([
            scrollView
        ])
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: 250)
        activateConstraints([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
            
            infoTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: CGFloat(infoTitleLabelHeight)),
            infoTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat(infoTitleLabelTopPadding)),
            infoTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(ViewConstants.padding)),
            infoTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: CGFloat(-1*ViewConstants.padding*2)),
            
            paragraphsStackView.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant: CGFloat(ViewConstants.padding)),
            paragraphsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(ViewConstants.padding)),
            paragraphsStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: CGFloat(-1*ViewConstants.padding*2)),
            paragraphsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: CGFloat(-1*ViewConstants.padding))
        ])
    }
    
    private func getSimpleTextView(_ font: UIFont) -> UITextView {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = font
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        
        return textView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
