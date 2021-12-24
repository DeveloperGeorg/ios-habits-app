import UIKit

class AddEditHabitViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = AddEditHabitView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Создать"
        self.title = "Править"
        navigationItem.largeTitleDisplayMode = .never
        
        let cancelButton = UIBarButtonItem()
        cancelButton.title = "Отменить"
        navigationItem.leftBarButtonItem = cancelButton
        
        let editButtonItem = UIBarButtonItem()
        editButtonItem.title = "Сохранить"
        navigationItem.rightBarButtonItem = editButtonItem
        let view = self.view as! AddEditHabitView
        view.removeButton.addTarget(self, action: #selector(removeButtonHandler), for: .touchDown)
        self.hidesBottomBarWhenPushed = true;
        
        view.datePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
    }
    
    @objc private func removeButtonHandler()
    {
        print("remove button was touched")
        let view = self.view as! AddEditHabitView
        present(view.alert, animated: true, completion: nil)
    }
    
    
    @objc func timeChanged(_ sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        let strDate = timeFormatter.string(from: sender.date)
        print("timeChanged: \(strDate)")
//        print("timeChanged")
    }
}
