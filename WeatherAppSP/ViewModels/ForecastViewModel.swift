import UIKit

struct ForecastViewModel {

    var time: String
    var temp: String
    let weatherDescription: UIImage

    init(forecast: Forecast, imageWeather: ImageWeather, weatherDateFormatter: WeatherDateFormatter) {
        time = weatherDateFormatter.getHourStringFromDate(date: forecast.time)
        temp = "\(forecast.temp)°"
        weatherDescription = imageWeather.getImageWeather(weatherDescriptionString: forecast.weatherDescription)
    }
}
