import UIKit

protocol SettingDetailTableViewCellDelegate: AnyObject {
    func settingDetailTableViewCell(_ cell: SettingDetailTableViewCell, didSwitchSettingTo: Bool)
}

final class SettingDetailTableViewCell: UITableViewCell {

    weak var delegate: SettingDetailTableViewCellDelegate?

    @IBOutlet private weak var nameDetailParameterLabel: UILabel!
    @IBOutlet private weak var selectionSwitch: UISwitch!

    func setup(settingDetailsModel: SettingDetailsModel) {
        nameDetailParameterLabel.text = settingDetailsModel.detailParameter.rawValue
        selectionSwitch.isOn = settingDetailsModel.isOn
    }

    // MARK: - IBAction
    @IBAction private func changedValueSwitch(_ sender: UISwitch) {
        delegate?.settingDetailTableViewCell(self, didSwitchSettingTo: sender.isOn)
    }
}
