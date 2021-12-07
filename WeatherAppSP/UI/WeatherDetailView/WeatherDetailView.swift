//
//  WeatherDetailView.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 25.11.2021.
//

import UIKit

class WeatherDetailView: UIView {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    func setup(weatherDetailModel: WeatherDetailModel) {
        nameLabel.text = weatherDetailModel.name
        valueLabel.text = weatherDetailModel.value
        imageView.image = weatherDetailModel.image

        LabelFormatter.shared.setupLabelSizeFont(label: nameLabel)
        LabelFormatter.shared.setupLabelSizeFont(label: valueLabel)
    }
}
