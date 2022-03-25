import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .init(red: 120/255, green: 120/255, blue: 240/255, alpha: 1)
    }

    func startViewScreen(title: String) {
        self.title = title
    }
}
