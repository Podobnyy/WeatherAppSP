//
//  ForecastViewModel.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 06.12.2021.
//

import UIKit

struct ForecastViewModel {

    let time: String
    let temp: String
    let weatherDescription: UIImage

    init(forecast: Forecast) {
        time = WeatherDateFormatter.shared.getHourStringFromDate(date: forecast.time)
        temp = "\(forecast.temp)°"
        weatherDescription = ImageWeather.shared
            .getImageWeather(weatherDescriptionString: forecast.weatherDescription)
    }
}
