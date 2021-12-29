import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .white
        tabBar.clipsToBounds = true
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor

        guard let items = tabBar.items else { return }

        let tabBarItems = [(title: "Locations", image: "location.circle.fill"),
                           (title: "Weather", image: "Weather"),
                           (title: "Forecast Days", image: "Calendar"),
                           (title: "Settings", image: "Settings")]

        items.enumerated().forEach {
            $1.title = tabBarItems[$0].title
            $1.image = UIImage(named: tabBarItems[$0].image)
        }
    }
}
