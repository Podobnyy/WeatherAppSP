import UIKit

final class ForecastDayTableViewCell: UITableViewCell {

    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var weatherIconImage: UIImageView!

    func setup(forecastDayViewModel: ForecastDayViewModel) {
        dayLabel.text = forecastDayViewModel.day
        tempLabel.text = forecastDayViewModel.temp
        weatherIconImage.image = forecastDayViewModel.weatherIcon
    }
}
