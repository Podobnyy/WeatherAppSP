//
//  SettingsTableViewCell.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 07.12.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameParameterLabel: UILabel!
    @IBOutlet private weak var valueSegmentedControl: UISegmentedControl!

    func setup(settingModel: SettingsModel) {
        nameParameterLabel.text = settingModel.parameter

        for index in 0..<settingModel.values.count {
            valueSegmentedControl.setAction(UIAction.init(title: settingModel.values[index],
                                                          image: nil,
                                                          identifier: nil,
                                                          discoverabilityTitle: nil,
                                                          attributes: UIMenuElement.Attributes.destructive,
                                                          state: UIMenuElement.State.mixed,
                                                          handler: { _ in }),
                                            forSegmentAt: index)
        }

        LabelFormatter.shared.setupLabelSizeFont(label: nameParameterLabel)
    }
}
