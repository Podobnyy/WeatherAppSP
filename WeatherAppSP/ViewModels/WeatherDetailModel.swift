//
//  WeatherDetailModel.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 06.12.2021.
//

import Foundation
import UIKit

struct WeatherDetailModel {

    let name: String
    let value: String
    let image: UIImage

    init(weatherDetailItem: WeatherDetailItem) {
        name = weatherDetailItem.name
        value = "\(weatherDetailItem.value)"
        image = ImageWeather.shared.getImageDetail(detailString: weatherDetailItem.name)
    }
}
