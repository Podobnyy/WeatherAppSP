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
    @IBAction func changedValueSwitch(_ sender: Any) {
        if (sender as AnyObject).isOn == true {
            delegate?.settingDetailTableViewCell(cell: self, selectionSwitch: true)
        } else {
            delegate?.settingDetailTableViewCell(cell: self, selectionSwitch: false)
        }
    }
}
