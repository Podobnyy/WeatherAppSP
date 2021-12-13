//
//  BaseViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 07.12.2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .init(red: 120/255, green: 120/255, blue: 240/255, alpha: 1)
    }

    func startViewScreen(title: String) {
        self.title = title
        self.tabBarItem.image = UIImage(named: title)
    }
}
