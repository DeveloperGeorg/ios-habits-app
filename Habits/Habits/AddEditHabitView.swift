import UIKit

class AddEditHabitView: UIView {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let contentView:UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    var nameTextFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название"
        label.font = FontKit.footnote
        
        return label
    }()
    
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.font = FontKit.body
        textField.textColor = .black
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        
        return textField
    }()
    
    var colorFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Цвет"
        label.font = FontKit.footnote
        
        return label
    }()
    
    fileprivate let colorPickedSize = 30
    
    var colorPicked: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.borderColor = ColorKit.systemPurple.cgColor
        view.backgroundColor = ColorKit.systemPurple
        
        return view
    }()
    
    var timeFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Время"
        label.font = FontKit.footnote
        
        return label
    }()
    
    var timeFieldValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontKit.body

        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: "Каждый день в ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]));
        text.append(NSAttributedString(string: "11:00 PM", attributes: [NSAttributedString.Key.foregroundColor: ColorKit.systemPurple]))
        label.attributedText = text
        
        return label
    }()
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.backgroundColor = .systemBackground
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = UIDatePicker.Mode.time
        return datePicker
    }()
    
    var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: UIControl.State.normal)
        button.setTitleColor(UIColor.red, for: UIControl.State.normal)
        button.backgroundColor = UIColor.clear
        
        return button
    }()
    
    var alert: UIAlertController = {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \("название выбранной привычки")?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) {
            UIAlertAction in
            print("Pressed Cancel action")
        }
        cancelAction.setValue(ColorKit.systemBlue, forKey: "titleTextColor")
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: "Удалить", style: .default) {
            UIAlertAction in
            print("Pressed OK action")
        }
        okAction.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(okAction)
        return alert
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        colorPicked.layer.cornerRadius = CGFloat(colorPickedSize/2)
        
        contentView.addSubviews([
            nameTextFieldLabel,
            nameTextField,
            colorFieldLabel,
            colorPicked,
            timeFieldLabel,
            timeFieldValueLabel,
            datePicker,
            removeButton
        ])
        scrollView.addSubviews([
            contentView
        ])
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
            
            nameTextFieldLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            nameTextFieldLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(ViewConstants.padding)),
            
            nameTextField.topAnchor.constraint(equalTo: nameTextFieldLabel.bottomAnchor, constant: CGFloat(ViewConstants.extraSmallPadding)),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(ViewConstants.padding)),
            
            colorFieldLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: CGFloat(ViewConstants.padding)),
            colorFieldLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(ViewConstants.padding)),
            
            colorPicked.widthAnchor.constraint(equalToConstant: CGFloat(colorPickedSize)),
            colorPicked.heightAnchor.constraint(equalToConstant: CGFloat(colorPickedSize)),
            colorPicked.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(ViewConstants.padding)),
            colorPicked.topAnchor.constraint(equalTo: colorFieldLabel.bottomAnchor, constant: CGFloat(ViewConstants.padding)),
            
            timeFieldLabel.topAnchor.constraint(equalTo: colorPicked.bottomAnchor, constant: CGFloat(ViewConstants.padding)),
            timeFieldLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(ViewConstants.padding)),
            
            timeFieldValueLabel.topAnchor.constraint(equalTo: timeFieldLabel.bottomAnchor, constant: CGFloat(ViewConstants.padding)),
            timeFieldValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(ViewConstants.padding)),
            
            datePicker.topAnchor.constraint(equalTo: timeFieldValueLabel.bottomAnchor, constant: CGFloat(ViewConstants.padding)),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(ViewConstants.padding)),
            
            removeButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(-1*ViewConstants.padding)),
            removeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
