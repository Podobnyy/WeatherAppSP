import UIKit

private enum Title: String {
    case weather = "Weather"
    case forecastDays = "Forecast Day"
    case settings = "Settings"
}

final class TabBarController: UITabBarController {

    var selectLocation: (() -> Void)?   // Output (Coordinator)

    var selectSettings: (() -> Void)?   // Coordinator
    var settingsSelected: (() -> Void)? // Coordinator

    var selectedTitle = Title.weather.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .white
        tabBar.clipsToBounds = true
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor

        guard let items = tabBar.items else { return }

        let tabBarItems = [(title: Title.weather.rawValue, image: "Weather"),
                           (title: Title.forecastDays.rawValue, image: "Calendar"),
                           (title: Title.settings.rawValue, image: "Settings")]

        items.enumerated().forEach {
            $1.title = tabBarItems[$0].title
            $1.image = UIImage(named: tabBarItems[$0].image)
        }
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        guard let newTitle = item.title else { return }

        guard !selectedTitle.elementsEqual(newTitle) else { return }

        if newTitle.elementsEqual(Title.settings.rawValue) {
            selectSettings?()
        }

        if selectedTitle.elementsEqual(Title.settings.rawValue) {
            settingsSelected?()
        }

        selectedTitle = newTitle
    }
}
