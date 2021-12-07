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

        self.tabBar.tintColor = .white
        self.tabBar.clipsToBounds = true
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.lightGray.cgColor
    }
}
