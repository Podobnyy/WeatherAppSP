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

    func getDateStringFromDate(date: Date) -> String {
        formatter.setLocalizedDateFormatFromTemplate("EEEEdMMMMyyyy")
        return formatter.string(from: date)
    }

    func getHourWithMinutesStringFromDate(date: Date) -> String {
        formatter.setLocalizedDateFormatFromTemplate("HHmm")
        return formatter.string(from: date)
    }

    func getHourStringFromDate(date: Date) -> String {
        formatter.setLocalizedDateFormatFromTemplate("HH")
        return formatter.string(from: date)
    }
}
