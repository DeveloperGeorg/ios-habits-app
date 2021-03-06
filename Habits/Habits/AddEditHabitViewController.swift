import UIKit

class AddEditHabitViewController: UIViewController {
    fileprivate var mode: AddEditHabitViewMode
    
    fileprivate var habit: Habit
    
    fileprivate let store: HabitsStore
    
    var addEditHabitView: AddEditHabitView
    
    public init(_ habit: Habit? = nil, _ mode: AddEditHabitViewMode? = nil) {
        if (habit != nil) {
            self.habit = habit!
            self.mode = AddEditHabitViewMode.editMode
        } else {
            self.habit = Habit(
                name: "",
                date: Date(),
                color: ColorKit.systemBlue
            )
            self.mode = AddEditHabitViewMode.createMode
        }
        if (mode != nil) {
            self.mode = mode!
        }
        self.store = HabitsStore.shared
        
        let view = AddEditHabitView(frame: .zero, mode: self.mode)
        view.setNameValue(self.habit.name)
        view.setColorValue(self.habit.color)
        view.setTimeValue(self.habit.date)
        self.addEditHabitView = view
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.addEditHabitView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Создать"
        if self.mode == AddEditHabitViewMode.editMode {
            self.title = "Править"
        }
        navigationItem.largeTitleDisplayMode = .never
        self.hidesBottomBarWhenPushed = true;
        
        let cancelButton = UIBarButtonItem()
        cancelButton.title = "Отменить"
        navigationItem.leftBarButtonItem = cancelButton
        cancelButton.target = self
        cancelButton.action = #selector(cancelButtonHandler)
        
        let editButtonItem = UIBarButtonItem()
        editButtonItem.title = "Сохранить"
        navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.target = self
        editButtonItem.action = #selector(saveButtonHandler)
        
        self.addEditHabitView.removeButton.addTarget(self, action: #selector(removeButtonHandler), for: .touchDown)
        
        self.addEditHabitView.datePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
        
        // Setting Delegate
        self.addEditHabitView.picker.delegate = self
        self.addEditHabitView.colorPicked.isUserInteractionEnabled = true
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openColorPicker))
        gesture.numberOfTapsRequired = 1
        self.addEditHabitView.colorPicked.addGestureRecognizer(gesture)
    }
    
    @objc private func openColorPicker()
    {
        self.present(self.addEditHabitView.picker, animated: true, completion: nil)
    }
    
    @objc private func removeButtonHandler()
    {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(self.habit.name)\"?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) {
            UIAlertAction in
        }
        cancelAction.setValue(ColorKit.systemBlue, forKey: "titleTextColor")
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: "Удалить", style: .default) {
            UIAlertAction in
            let store = HabitsStore.shared
            store.habits.removeAll{$0 == self.habit}
            store.save()
            NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
            self.navigationController?.popBack(3)
        }
        okAction.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func timeChanged(_ sender: UIDatePicker) {
        self.addEditHabitView.setTimeValue(sender.date)
    }
    
    @objc private func saveButtonHandler()
    {
        self.habit.name = self.addEditHabitView.getNameValue()
        self.habit.color = self.addEditHabitView.colorPicked.backgroundColor ?? ColorKit.systemPurple
        self.habit.date = self.addEditHabitView.datePicker.date
        if self.mode == AddEditHabitViewMode.createMode {
            self.store.habits.append(self.habit)
        }
        self.store.save()
        NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancelButtonHandler()
    {
        navigationController?.popViewController(animated: true)
    }
}

extension AddEditHabitViewController: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.addEditHabitView.setColorValue(viewController.selectedColor)
        
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.addEditHabitView.setColorValue(viewController.selectedColor)
    }
}
