import Foundation

typealias CurrentWeatherLoadComplitionalBlock = (_ result: CurrentWeatherModel?) -> Void
typealias ForecastCityLoadComplitionalBlock = (_ result: CityWeather?) -> Void

final class NetworkManager {
    private let beginApi = "https://api.openweathermap.org/data/2.5/"
    private let apiForForecastCity = "forecast?"
    private let apiForCurrentWeatherCity = "weather?"
    private let apiSettings = "units=metric&"
    private let apiKey = "837e4c533ab63ecab027461450b08c1d"

    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    static let shared = NetworkManager()

    private init() {}

    // MARK: - Call Current Weather Request
    func callCurrentWeatherRequest(location: LocationModel, completion: @escaping CurrentWeatherLoadComplitionalBlock) {

        let urlString = beginApi + apiForCurrentWeatherCity + apiSettings +
                        "lat=\(location.latitude)&lon=\(location.longitude)" +
                        "&appid=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        session.dataTask(with: url) { (data, _, error) in

            guard let data = data else { return }

            do {
                let responseModel: ResponseCurrentWeatherModel =
                    try self.decoder.decode(ResponseCurrentWeatherModel.self, from: data)

                let currentWeather = self.getCurrentWeatherModelFromResponseModel(responseModel)
                completion(currentWeather)
            } catch {
                print(error)
            }
        }.resume()
    }

    private func getCurrentWeatherModelFromResponseModel(_ responseModel: ResponseCurrentWeatherModel
    ) -> CurrentWeatherModel {
        let currentWeatherModel = CurrentWeatherModel(name: responseModel.name,
                                                      temp: responseModel.main.temp,
                                                      iconString: responseModel.weather[0].icon)
        return currentWeatherModel
    }

    // MARK: - For Forecast Location
    func callForecastLocationWeatherRequest(location: LocationModel,
                                            completion: @escaping ForecastCityLoadComplitionalBlock) {
        let urlString = beginApi + apiForForecastCity + apiSettings +
                        "lat=\(location.latitude)&lon=\(location.longitude)" +
                        "&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        session.dataTask(with: url) { (data, _, error) in

            guard let data = data else { return }

            do {
                let responseModel: ResponseModel = try self.decoder.decode(ResponseModel.self, from: data)

                let cityWeather = self.getCityWeatherFromResponseModel(responseModel)
                completion(cityWeather)
            } catch {
                print(error)
            }
        }.resume()
    }

    private func getCityWeatherFromResponseModel(_ responseModel: ResponseModel) -> CityWeather {
        let cityWeather = CityWeather(
            name: responseModel.city.name,
            weatherDescription: responseModel.list[0].weather[0].description,
            date: Date(timeIntervalSince1970: TimeInterval(responseModel.list[0].dateTime)),
            temp: responseModel.list[0].main.temp,
            sunrise: Date(timeIntervalSince1970: TimeInterval(responseModel.city.sunrise)),
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
            let forecast = Forecast(time: Date(timeIntervalSince1970: TimeInterval(item.dateTime)),
                                         temp: item.main.temp,
                                         weatherDescription: item.weather[0].description)
            result.append(forecast)
        }
        return result
    }
}
