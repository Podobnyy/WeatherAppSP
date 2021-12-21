//
//  SettingsDetailsTableViewCell.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 07.12.2021.
//

import UIKit

final class SettingsDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func setup(settingsDetailsModel: SettingsDetailsModel) {
        titleLabel.text = settingsDetailsModel.title
    }
}
