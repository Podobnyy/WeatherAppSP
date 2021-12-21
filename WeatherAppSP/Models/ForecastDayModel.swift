//
//  ForecastDayModel.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 20.12.2021.
//

import Foundation

enum ForecastDayKey: String {
    case day
    case temp
    case weatherIcon
}

final class ForecastDayModel: NSObject, NSCoding {

    let day: String
    let temp: Double
    let weatherIcon: String

    init(day: String, temp: Double, weatherIcon: String) {
        self.day = day
        self.temp = temp
        self.weatherIcon = weatherIcon
    }

    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(day, forKey: ForecastDayKey.day.rawValue)
        coder.encode(temp, forKey: ForecastDayKey.temp.rawValue)
        coder.encode(weatherIcon, forKey: ForecastDayKey.weatherIcon.rawValue)
    }

    required init?(coder: NSCoder) {
        day = coder.decodeObject(forKey: ForecastDayKey.day.rawValue) as? String ?? ""
        temp = coder.decodeDouble(forKey: ForecastDayKey.temp.rawValue)
        weatherIcon = coder.decodeObject(forKey: ForecastDayKey.weatherIcon.rawValue) as? String ?? ""
    }
}
