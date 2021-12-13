//
//  NetworkManager.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 24.11.2021.
//

import Foundation

typealias CityLoadComplitionalBlock = (_ result: CityWeather?) -> Void

class NetworkManager {
    private let beginApiForCity = "https://api.openweathermap.org/data/2.5/forecast?units=metric&q="
    private let apiKey = "837e4c533ab63ecab027461450b08c1d"

    private let session = URLSession.shared

    static let shared = NetworkManager()

    private init() {}

    func callCityWeatherRequest(cityNameString: String, completion: @escaping CityLoadComplitionalBlock ) {
        let urlString = beginApiForCity + cityNameString + "&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        session.dataTask(with: url) { (data, _, error) in

            guard let data = data else { return }

            do {
                let decoter = JSONDecoder()
                let responseModel: ResponseModel = try decoter.decode(ResponseModel.self, from: data)

                let cityWeather = self.getCityWeatherFromResponseModel(responseModel: responseModel)
                completion(cityWeather)
            } catch {
                print(error)
            }
        }.resume()
    }

    private func getCityWeatherFromResponseModel(responseModel: ResponseModel) -> CityWeather {
        let cityWeather = CityWeather.init(name: responseModel.city.name,
                                           weatherDescription: responseModel.list[0].weather[0].description,
                                           date: Date(timeIntervalSince1970:
                                                        TimeInterval(responseModel.list[0].dateTime)),
                                           temp: responseModel.list[0].main.temp,
                                           sunrise: Date(timeIntervalSince1970:
                                                            TimeInterval(responseModel.city.sunrise)),
                                           sunset: Date(timeIntervalSince1970: TimeInterval(responseModel.city.sunset)),
                                           forecasts: getForecastsFromResponseModel(responseModel: responseModel),
                                           humidity: responseModel.list[0].main.humidity,
                                           windSpeed: responseModel.list[0].wind.speed,
                                           tempMin: responseModel.list[0].main.tempMin,
                                           tempMax: responseModel.list[0].main.tempMax,
                                           feelsLike: responseModel.list[0].main.feelsLike,
                                           pressure: responseModel.list[0].main.pressure)
        return cityWeather
    }

    private func getForecastsFromResponseModel(responseModel: ResponseModel) -> [Forecast] {
        var result = [Forecast]()

        for item in responseModel.list {
            let forecast = Forecast.init(time: Date(timeIntervalSince1970: TimeInterval(item.dateTime)),
                                         temp: item.main.temp,
                                         weatherDescription: item.weather[0].description)
            result.append(forecast)
        }
        return result
    }
}
