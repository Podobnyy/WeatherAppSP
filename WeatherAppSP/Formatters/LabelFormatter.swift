//
//  LabelFormatter.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 06.12.2021.
//

import UIKit

struct LabelFormatter {

    static let shared = LabelFormatter()

    private init() {}

    // MARK: - func
    func setupLabelSizeFont(label: UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
    }
}
