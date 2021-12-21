//
//  WeatherDetailView.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 25.11.2021.
//

import UIKit

final class WeatherDetailView: UIView {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    func setup(weatherDetailViewModel: WeatherDetailViewModel) {
        nameLabel.text = weatherDetailViewModel.name
        valueLabel.text = weatherDetailViewModel.value
        imageView.image = weatherDetailViewModel.image

        LabelFormatter.shared.setupLabelSizeFont(label: nameLabel)
        LabelFormatter.shared.setupLabelSizeFont(label: valueLabel)
    }
}
