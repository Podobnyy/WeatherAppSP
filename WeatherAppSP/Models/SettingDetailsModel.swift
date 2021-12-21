//
//  WeatherDetailsModel.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 13.12.2021.
//

import Foundation

enum Detail: String, CaseIterable {
    case humidity = "Humidity"
    case windSpeed = "Wind Speed"
    case minTemp = "Min Temp"
    case maxTemp = "Max Temp"
    case feelsLike = "Feels Like"
    case pressure = "Pressure"
}

final class SettingDetailsModel: NSObject, NSCoding {
    let detailParameter: Detail
    var isOn: Bool

    init(detailParameter: Detail, isOn: Bool) {
        self.detailParameter = detailParameter
        self.isOn = isOn
    }

    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(detailParameter.rawValue, forKey: "detailParameter")
        coder.encode(isOn, forKey: "isOn")
    }

    required init?(coder: NSCoder) {
        detailParameter = Detail(rawValue: (coder.decodeObject(forKey: "detailParameter")
                                            as? String ?? "")) ?? Detail.humidity
        isOn = Bool(coder.decodeBool(forKey: "isOn"))
    }
}
