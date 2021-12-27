//
//  LocationModel.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 27.12.2021.
//

import Foundation

struct LocationModel {

    let latitude: Double
    let longitude: Double

    let name: String?
    let temp: Double?
    let iconString: String?

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude

        name = nil
        temp = nil
        iconString = nil
    }
}
