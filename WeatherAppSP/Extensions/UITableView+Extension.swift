//
//  UITableView+Extension.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 07.12.2021.
//

import UIKit

// MARK: - Generics for UITableViewCell
protocol ReusableTableView {

    static var reuseIdentifier: String { get }
}

extension ReusableTableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableTableView {}

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
                    fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
}
