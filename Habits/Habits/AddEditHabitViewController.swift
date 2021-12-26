import UIKit

class AddEditHabitViewController: UIViewController {
    fileprivate var mode: AddEditHabitViewMode
    
    fileprivate var habit: Habit
    
    fileprivate let store: HabitsStore
    
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
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = AddEditHabitView(frame: .zero, mode: self.mode)
        view.setNameValue(self.habit.name)
        view.setColorValue(self.habit.color)
        view.setTimeValue(self.habit.date)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) {
            UIAlertAction in
            print("Pressed Cancel action")
        }
        cancelAction.setValue(ColorKit.systemBlue, forKey: "titleTextColor")
        view.alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: "Удалить", style: .default) {
            UIAlertAction in
            let store = HabitsStore.shared
            store.habits.removeAll{$0 == self.habit}
            store.save()
            NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
            self.navigationController?.popBack(3)
        }
        okAction.setValue(UIColor.red, forKey: "titleTextColor")
        view.alert.addAction(okAction)
        
        
        self.view = view
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
        
        let view = self.view as! AddEditHabitView
        view.removeButton.addTarget(self, action: #selector(removeButtonHandler), for: .touchDown)
        
        view.datePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
    }
    
    @objc private func removeButtonHandler()
    {
        print("remove button was touched")
        let view = self.view as! AddEditHabitView
        present(view.alert, animated: true, completion: nil)
    }
    
    @objc func timeChanged(_ sender: UIDatePicker) {
        self.habit.date = sender.date
        let view = self.view as! AddEditHabitView
        view.setTimeValue(self.habit.date)
    }
    
    @objc private func saveButtonHandler()
    {
        let view = self.view as! AddEditHabitView
        self.habit.name = view.getNameValue()
        print("\(self.habit.name)")
        if self.mode == AddEditHabitViewMode.createMode {
            self.store.habits.append(self.habit)
        }
        self.store.save()
        NotificationCenter.default.post(name: NSNotification.Name("load"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancelButtonHandler()
    {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: false)
    }
    
    
}
