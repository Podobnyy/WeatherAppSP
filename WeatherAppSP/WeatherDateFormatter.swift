//
//  WeatherDateFormatter.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 06.12.2021.
//

import Foundation

class WeatherDateFormatter {

    static let shared = WeatherDateFormatter()

    private init() {}

    let formatter = DateFormatter()

    // MARK: - func
    func getDateStringFromDate(date: Date) -> String {
        formatter.setLocalizedDateFormatFromTemplate("EEEEdMMMMyyyy")

        let result = formatter.string(from: date)
        return result
    }

    func getTimeStringFromDate(date: Date) -> String {
        formatter.setLocalizedDateFormatFromTemplate("HHmm")

        let result = formatter.string(from: date)
        return result
    }

    func getHourStringFromDate(date: Date) -> String {
        formatter.setLocalizedDateFormatFromTemplate("HH")

        let result = formatter.string(from: date)
        return result
    }
}
