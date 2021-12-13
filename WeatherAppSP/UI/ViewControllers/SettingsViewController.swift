//
//  SettingsViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 07.12.2021.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var parametersDataSource = [SettingsModel]()
    private let weatherDetailsDataSource = [SettingsDetailsModel.init()]
    private var tableViewDataSource = [[Any]]()

    private let parametersArray: [Any] = [Hour.self, Unit.self, Distance.self]
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
        for parameter in parametersArray {
            var parameterString = ""
            var values = [String]()
            var selectedValue = 0

            switch parameter {
            case is Hour.Type:
                parameterString = String(describing: Hour.self)
                values = hourArray.map { $0.rawValue }
                selectedValue = hourArray.firstIndex(where: { $0 == settingsManager.getValueHour() }) ?? 0
            case is Unit.Type:
                parameterString = String(describing: Unit.self)
                values = unitArray.map { $0.rawValue }
                selectedValue = unitArray.firstIndex(where: { $0 == settingsManager.getValueUnit() }) ?? 0
            case is Distance.Type:
                parameterString = String(describing: Distance.self)
                values = distanceArray.map { $0.rawValue }
                selectedValue = distanceArray.firstIndex(where: { $0 == settingsManager.getValueDistance() }) ?? 0
            default:
                continue
            }

            let settingsModel = SettingsModel(parameter: parameterString, values: values, selectedValue: selectedValue)
            parametersDataSource.append(settingsModel)
        }
    }

    // MARK: - TableView
    private func setupTableView() {
        tableViewDataSource = [parametersDataSource, weatherDetailsDataSource]
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
        return tableViewDataSource[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch tableViewDataSource[indexPath.section].first {
        case is SettingsModel:
            let cell: SettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(settingModel: parametersDataSource[indexPath.row])
            cell.delegate = self
            return cell
        case is SettingsDetailsModel:
            let cell: SettingsDetailsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(settingsDetailsModel: weatherDetailsDataSource[indexPath.row])
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = tableView.frame.size.width
        let aspectRatio: CGFloat = 414 / 80
        return width / aspectRatio
    }

    // MARK: - Navigation
    // TODO: Ask Max: Where put
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
// TODO: Ask Max: Cell .xib / class
        guard (tableViewDataSource[indexPath.section].first as? SettingsDetailsModel) != nil else { return }

        let weatherDetailStoryboard =
            UIStoryboard.init(name: String(describing: WeatherDetailViewController.self), bundle: nil)
        let weatherDetailViewController =
            weatherDetailStoryboard.instantiateViewController(withIdentifier:
                                                                String(describing: WeatherDetailViewController.self))
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
//      OR  self.show(weatherDetailViewController, sender: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SettingsTableViewCellDelegate
extension SettingsViewController: SettingsTableViewCellDelegate {

    func settingsTableViewCell(cell: SettingsTableViewCell, value: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let parameter = parametersArray[indexPath.row]
        SettingsManager.shared.setSettings(parameter: parameter, value: value)
    }
}
