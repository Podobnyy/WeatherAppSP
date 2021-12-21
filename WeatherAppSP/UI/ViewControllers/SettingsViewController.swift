//
//  SettingsViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 07.12.2021.
//

import UIKit

final class SettingsViewController: BaseViewController {

    enum Section {
        case parameters
        case details
    }

    enum Parameter {
        case hour
        case unit
        case distance
    }

    @IBOutlet private weak var tableView: UITableView!

    private var parametersDataSource = [SettingsModel]()
    private let weatherDetailsDataSource = [SettingsDetailsModel.init()]
    private var tableViewDataSource: [Section] = [.parameters, .details]

    private let parametersArray: [Parameter] = [.hour, .unit, .distance]
    private let hourArray = Hour.allCases
    private let unitArray = Unit.allCases
    private let distanceArray = Distance.allCases

    private let settingsManager = SettingsManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        startViewScreen(title: "Settings")

        setupParametersDataSource()
        setupTableView()
    }

    // MARK: - SettingsModels
    private func setupParametersDataSource() {
        parametersArray.forEach { parameter in
            var parameterString = ""
            var values = [String]()
            var selectedValue = 0

            switch parameter {
            case .hour:
                parameterString = String(describing: Hour.self)
                values = hourArray.map { $0.rawValue }
                selectedValue = hourArray.firstIndex(where: { $0 == settingsManager.getValueHour() }) ?? 0
            case .unit:
                parameterString = String(describing: Unit.self)
                values = unitArray.map { $0.rawValue }
                selectedValue = unitArray.firstIndex(where: { $0 == settingsManager.getValueUnit() }) ?? 0
            case .distance:
                parameterString = String(describing: Distance.self)
                values = distanceArray.map { $0.rawValue }
                selectedValue = distanceArray.firstIndex(where: { $0 == settingsManager.getValueDistance() }) ?? 0
            }

            let settingsModel = SettingsModel(parameter: parameterString,
                                              values: values,
                                              selectedValue: selectedValue)
            parametersDataSource.append(settingsModel)
        }
    }

    // MARK: - TableView
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(cell: SettingsTableViewCell.self)
        tableView.register(cell: SettingsDetailsTableViewCell.self)
    }
}

// MARK: - Extensions
extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViewDataSource[section] {
        case .details: return weatherDetailsDataSource.count
        case .parameters: return parametersDataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableViewDataSource[indexPath.section] {
        case .parameters:
            let cell: SettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(settingModel: parametersDataSource[indexPath.row])
            cell.delegate = self
            return cell
        case .details:
            let cell: SettingsDetailsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(settingsDetailsModel: weatherDetailsDataSource[indexPath.row])
            return cell
        }
    }
}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.width / Constants.aspectRatioTableViewCells
    }

    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableViewDataSource[indexPath.section] {
        case .parameters:
            break
        case .details:
            let settingDetailStoryboard =
                UIStoryboard.init(name: String(describing: SettingDetailsViewController.self), bundle: nil)
            let settingDetailViewController = settingDetailStoryboard.instantiateViewController(withIdentifier:
                                                                String(describing: SettingDetailsViewController.self))

            self.navigationController?.pushViewController(settingDetailViewController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// MARK: - SettingsTableViewCellDelegate
extension SettingsViewController: SettingsTableViewCellDelegate {

    func settingsTableViewCell(cell: SettingsTableViewCell, selectedValue: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        let parameter = parametersArray[indexPath.row]

        switch parameter {
        case .hour:
            guard let newValue = Hour.init(rawValue: Hour.allCases[selectedValue].rawValue) else { return }
            settingsManager.setValueHour(newValue: newValue)
        case .unit:
            guard let newValue = Unit.init(rawValue: Unit.allCases[selectedValue].rawValue) else { return }
            settingsManager.setValueUnit(newValue: newValue)
        case .distance:
            guard let newValue = Distance.init(rawValue: Distance.allCases[selectedValue].rawValue) else { return }
            settingsManager.setValueDistance(newValue: newValue)
        }
    }
}
