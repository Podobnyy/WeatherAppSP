//
//  SettingDetailTableViewCell.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 13.12.2021.
//

import UIKit

class SettingDetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameDetailParameterLabel: UILabel!
    @IBOutlet private weak var selectionSwitch: UISwitch!

    func setup(settingDetailsModel: SettingDetailsModel) {
        nameDetailParameterLabel.text = settingDetailsModel.detailParameter.rawValue
        selectionSwitch.isOn = settingDetailsModel.isOn
    }

}
