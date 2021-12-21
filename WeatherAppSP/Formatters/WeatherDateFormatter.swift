//
//  WeatherDateFormatter.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 06.12.2021.
//

import Foundation

final class WeatherDateFormatter {

    static let shared = WeatherDateFormatter()

    private init() {}

    let formatter = DateFormatter()

    func getDayStringFromDate(date: Date) -> String {
        formatter.setLocalizedDateFormatFromTemplate("EEEE")
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }

    func getDateStringFromDate(date: Date) -> String {
        formatter.setLocalizedDateFormatFromTemplate("EEEEdMMMMyyyy")
        formatter.locale = Locale(identifier: "en_US")
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
