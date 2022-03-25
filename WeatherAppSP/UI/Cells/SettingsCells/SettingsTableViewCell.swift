import UIKit

protocol SettingsTableViewCellDelegate: AnyObject {
    func settingsTableViewCell(cell: SettingsTableViewCell, selectedValue: Int)
}

final class SettingsTableViewCell: UITableViewCell {

    weak var delegate: SettingsTableViewCellDelegate?

    @IBOutlet private weak var nameParameterLabel: UILabel!
    @IBOutlet private weak var valueSegmentedControl: UISegmentedControl!

    var labelFormatter: LabelFormatter!

    // MARK: - funcs
    func setup(settingModel: SettingsModel) {
        nameParameterLabel.text = settingModel.parameter
        labelFormatter.setupLabelSizeFont(label: nameParameterLabel)

        settingModel.values.enumerated().forEach {
            valueSegmentedControl.setAction(UIAction.init(title: $1,
                                                          image: nil,
                                                          identifier: nil,
                                                          discoverabilityTitle: nil,
                                                          attributes: UIMenuElement.Attributes.destructive,
                                                          state: UIMenuElement.State.mixed,
                                                          handler: { _ in }),
                                            forSegmentAt: $0)
        }
        valueSegmentedControl.selectedSegmentIndex = settingModel.selectedValue
    }

    // MARK: - IBActions
    @IBAction func changedValueSegmentedControl(_ sender: UISegmentedControl) {
        delegate?.settingsTableViewCell(cell: self, selectedValue: sender.selectedSegmentIndex)
    }
}
