//
//  TabBarController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 02.12.2021.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .white
        tabBar.clipsToBounds = true
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor

        guard let items = self.tabBar.items else { return }

        let tabBarItems = ["Weather", "Settings"]

        for index in 0..<items.count {
            items[index].title = tabBarItems[index]
            items[index].image = UIImage(named: tabBarItems[index])
        }

    }
}
