//
//  SettingsViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 07.12.2021.
//

import UIKit
// TODO: Для храниния данных - UserDefault

class SettingsViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var settingsDataSource = [SettingsModel]()
    private let settingsDetailsModel = SettingsDetailsModel.init() // TODO: Check: maybe change

    override func viewDidLoad() {
        super.viewDidLoad()
        startViewScreen(title: "Settings")

        setSettingsModels()
        setupTableView()
    }

    // MARK: - SettingsModels
    private func setSettingsModels() {
        let hourSettingsModel = SettingsModel(parameter: "Hour", values: ["12", "24"], selectedValue: 0)
        let unitSettingsModel = SettingsModel(parameter: "Unit", values: ["°C", "°F"], selectedValue: 0)
        let distanceSettingsModel = SettingsModel(parameter: "Distance", values: ["km", "mill"], selectedValue: 0)

        settingsDataSource = [hourSettingsModel, unitSettingsModel, distanceSettingsModel]
    }

    // MARK: - TableView
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.register(UINib(nibName: "SettingsDetailsTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: "SettingsDetailsTableViewCell")
    }
}

// MARK: - Extensions
extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return settingsDataSource.count
        case 1: return 1
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell: SettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(settingModel: settingsDataSource[indexPath.row])
            return cell
        case 1:
            let cell: SettingsDetailsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(settingsDetailsModel: settingsDetailsModel) // TODO: Check: maybe change
        default:
            return UITableViewCell()
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
}
