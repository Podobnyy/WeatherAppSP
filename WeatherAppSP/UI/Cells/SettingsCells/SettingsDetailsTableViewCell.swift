import UIKit

final class SettingsDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func setup(settingsDetailsModel: SettingsDetailsModel) {
        titleLabel.text = settingsDetailsModel.title
    }
}
