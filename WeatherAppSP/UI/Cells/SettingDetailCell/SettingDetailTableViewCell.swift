//
//  SettingDetailTableViewCell.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 13.12.2021.
//

import UIKit

protocol SettingDetailTableViewCellDelegate: AnyObject {
    func settingDetailTableViewCell(cell: SettingDetailTableViewCell, selectionSwitch: Bool)
}

class SettingDetailTableViewCell: UITableViewCell {

    weak var delegate: SettingDetailTableViewCellDelegate?

    @IBOutlet private weak var nameDetailParameterLabel: UILabel!
    @IBOutlet private weak var selectionSwitch: UISwitch!

    func setup(settingDetailsModel: SettingDetailsModel) {
        nameDetailParameterLabel.text = settingDetailsModel.detailParameter.rawValue
        selectionSwitch.isOn = settingDetailsModel.isOn
    }

    // MARK: - IBAction
    @IBAction func changedValueSwitch(_ sender: UISwitch) {
        delegate?.settingDetailTableViewCell(cell: self, selectionSwitch: sender.isOn)
    }
}
