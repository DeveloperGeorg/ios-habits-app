import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Информация"

    }
    
    override func loadView() {
        let view = InfoView()
        self.view = view
    }
}
