//
//  СonverterManager.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 09.12.2021.
//

import Foundation

class СonverterManager {

    static let shared = СonverterManager()

    private init() {}

    // MARK: - funcs
    func getTwelveHourFromTwentyFourHour(twentyFourHour: Int) -> Int {
        var result: Int = 0

        switch twentyFourHour {
        case 0: result = 12
        case 1...12: result = twentyFourHour
        case 13...24: result = twentyFourHour - 12
        default:
            break
        }

        return result
    }

    func getFahrenheitFromCelsius(celsius: Double) -> Double {
        return ((celsius * 9 / 5) + 32)
    }

    func getMileFromKilometre(kilometre: Double) -> Double {
        return kilometre * 0.621371
    }
}
