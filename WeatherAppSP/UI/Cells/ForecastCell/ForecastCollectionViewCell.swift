import UIKit

final class ForecastCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionImage: UIImageView!

    var labelFormatter: LabelFormatter!

    func setup(forecastViewModel: ForecastViewModel) {
        timeLabel.text = forecastViewModel.time
        tempLabel.text = forecastViewModel.temp
        weatherDescriptionImage.image = forecastViewModel.weatherDescription

        labelFormatter.setupLabelSizeFont(label: timeLabel)
        labelFormatter.setupLabelSizeFont(label: tempLabel)
    }
}
