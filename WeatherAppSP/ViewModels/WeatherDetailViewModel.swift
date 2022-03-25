import UIKit

struct WeatherDetailViewModel {

    let name: String
    let value: String
    let image: UIImage

    init(weatherDetailItem: WeatherDetailItem, imageWeather: ImageWeather) {
        name = weatherDetailItem.name
        value = "\(weatherDetailItem.value)"
        image = imageWeather.getImageDetail(detailString: weatherDetailItem.name)
    }
}
