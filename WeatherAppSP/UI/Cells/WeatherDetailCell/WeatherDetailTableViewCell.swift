//
//  WeatherDetailTableViewCell.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 13.12.2021.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameDetailParameterLabel: UILabel!
    @IBOutlet private weak var isOnSwifch: UISwitch!        // TODO: Ask Max: name? maybe flagSwifch? OR?

    func setup(weatherDetailsModel: WeatherDetailsModel) {
        nameDetailParameterLabel.text = weatherDetailsModel.nameDetailParameter
        isOnSwifch.isOn = weatherDetailsModel.isOn
    }

}
