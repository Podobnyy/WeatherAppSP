import UIKit

final class WeatherDetailView: UIView {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    var labelFormatter: LabelFormatter!

    func setup(weatherDetailViewModel: WeatherDetailViewModel) {
        nameLabel.text = weatherDetailViewModel.name
        valueLabel.text = weatherDetailViewModel.value
        imageView.image = weatherDetailViewModel.image

        labelFormatter.setupLabelSizeFont(label: nameLabel)
        labelFormatter.setupLabelSizeFont(label: valueLabel)
    }
}
