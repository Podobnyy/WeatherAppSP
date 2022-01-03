import UIKit

final class LocationTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var weatherIconImage: UIImageView!

    func setup(locationViewModel: LocationViewModel) {
        nameLabel.text = locationViewModel.name
        tempLabel.text = locationViewModel.temp
        weatherIconImage.image = locationViewModel.weatherIcon
    }
}
