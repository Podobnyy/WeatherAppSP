//
//  СonverterManager.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 09.12.2021.
//

import Foundation

final class СonverterManager {

    private let weatherDateFormatter = WeatherDateFormatter.shared

    init() {}

    func getTwelveHourFromTwentyFourHour(_ twentyFourHour: Int) -> String {
        var result = ""

        switch twentyFourHour {
        case 0: result = "12am"
        case 1...12: result = "\(twentyFourHour)am"
        case 13...24: result = "\(twentyFourHour - 12)pm"
        default:
            break
        }

        return result
    }

    func getTwelveHourFromTwentyFourHourWithMinutes(_ twentyFourHour: String) -> String {
        let indexStart = twentyFourHour.index(twentyFourHour.startIndex, offsetBy: 2)
        let hourTime = Int(String(twentyFourHour[..<indexStart])) ?? 0
        var newHourTime = ""
        var amPm = ""

        switch hourTime {
        case 0:
            newHourTime = "12"
            amPm = "am"
        case 1...12:
            newHourTime = "\(hourTime)"
            amPm = "am"
        case 13...24:
            newHourTime = "\(hourTime - 12)"
            amPm = "pm"
        default:
            break
        }

        let indexEnd = twentyFourHour.index(twentyFourHour.startIndex, offsetBy: twentyFourHour.count)
        return newHourTime + String(twentyFourHour[indexStart..<indexEnd]) + amPm
    }

    func getFahrenheitFromСelsius(_ celsius: Double) -> Double {
        return ((celsius * 9 / 5) + 32)
    }

    func getFootSecondFromMetreSecond(_ metreSecond: Double) -> Double {
        return metreSecond * 3.28084
    }
}
