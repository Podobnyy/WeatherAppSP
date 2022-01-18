import UIKit

enum TabBarTitle: String {
    case weather = "Weather"
    case forecastDays = "Forecast Day"
    case settings = "Settings"
}

private enum TabBarImageName: String {
    case weather = "Weather"
    case forecastDays = "Calendar"
    case settings = "Settings"
}

final class TabBarController: UITabBarController {

    var onSelectSettingsAction: (() -> Void)?
    var onSettingsSelectedAction: (() -> Void)?

    var titleItems = [TabBarTitle]()

    var selectedTitle = TabBarTitle.weather.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .white
        tabBar.clipsToBounds = true
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor

        setupTabBarItems()
    }

    // MARK: - TabBarItems
    private func setupTabBarItems() {
        guard let items = tabBar.items else { return }

        let tabBarItems = getTabBarItems()
        items.enumerated().forEach {
            $1.title = tabBarItems[$0].title.rawValue
            $1.image = UIImage(named: tabBarItems[$0].imageName.rawValue)
        }
    }

    private func getTabBarItems() -> [(title: TabBarTitle, imageName: TabBarImageName)] {
        var tabBarItems = [(title: TabBarTitle, imageName: TabBarImageName)]()
        titleItems.forEach { titleItem in
            let item = (title: titleItem, imageName: getImageName(titleItem))
            tabBarItems.append(item)
        }
        return tabBarItems
    }

    private func getImageName(_ title: TabBarTitle) -> TabBarImageName {
        switch title {
        case .weather: return .weather
        case .forecastDays: return .forecastDays
        case .settings: return .settings
        }
    }

    // MARK: - Navigation
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        guard let newTitle = item.title else { return }

        guard !selectedTitle.elementsEqual(newTitle) else { return }

        if newTitle.elementsEqual(TabBarTitle.settings.rawValue) {
            onSelectSettingsAction?()
        }

        if selectedTitle.elementsEqual(TabBarTitle.settings.rawValue) {
            onSettingsSelectedAction?()
        }

        selectedTitle = newTitle
    }
}
