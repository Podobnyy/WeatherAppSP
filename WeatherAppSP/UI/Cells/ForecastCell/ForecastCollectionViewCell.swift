//
//  ForecastCollectionViewCell.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 01.12.2021.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionImage: UIImageView!

    func setup(forecastViewModel: ForecastViewModel) {
        timeLabel.text = forecastViewModel.time
        tempLabel.text = forecastViewModel.temp
        weatherDescriptionImage.image = forecastViewModel.weatherDescription

        LabelFormatter.shared.setupLabelSizeFont(label: timeLabel)
        LabelFormatter.shared.setupLabelSizeFont(label: tempLabel)
    }
}
