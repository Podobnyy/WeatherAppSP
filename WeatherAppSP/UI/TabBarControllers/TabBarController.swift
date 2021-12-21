//
//  TabBarController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 02.12.2021.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .white
        tabBar.clipsToBounds = true
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor

        guard let items = tabBar.items else { return }

        let tabBarTitleItems = ["Locations", "Weather", "Forecast Days", "Settings"]
        let tabBarImageItems = ["location.circle.fill", "Weather", "Calendar", "Settings"]

        items.enumerated().forEach {
            $1.title = tabBarTitleItems[$0]
            $1.image = UIImage(named: tabBarImageItems[$0])
        }
    }
}
