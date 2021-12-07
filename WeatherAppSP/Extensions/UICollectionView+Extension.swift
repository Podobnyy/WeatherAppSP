//
//  UICollectionView+Extension.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 07.12.2021.
//

import UIKit

// MARK: - Generics for UICollectionViewCell
protocol ReusableView {

    static var reuseIdentifier: String { get }
}

extension ReusableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
                    fatalError("Unable to Dequeue Reusable Collection View Cell")
        }
        return cell
    }
}
