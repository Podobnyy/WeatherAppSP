//
//  WeatherDetailViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 13.12.2021.
//

import UIKit

class WeatherDetailViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var tableViewDataSource = [WeatherDetailsModel]()

    private let settingsManager = SettingsManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupDataSource()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(cell: WeatherDetailTableViewCell.self)
    }

    private func setupDataSource() {
        tableViewDataSource.append(settingsManager.getWeatherDetails(nameDetailParameter: .humidity))
        tableViewDataSource.append(settingsManager.getWeatherDetails(nameDetailParameter: .windSpeed))
        tableViewDataSource.append(settingsManager.getWeatherDetails(nameDetailParameter: .minTemp))
        tableViewDataSource.append(settingsManager.getWeatherDetails(nameDetailParameter: .maxTemp))
        tableViewDataSource.append(settingsManager.getWeatherDetails(nameDetailParameter: .feelsLike))
        tableViewDataSource.append(settingsManager.getWeatherDetails(nameDetailParameter: .pressure))
    }
}

// MARK: - Extensions
extension WeatherDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(weatherDetailsModel: tableViewDataSource[indexPath.row])
//        cell.delegate = self
        return cell
    }

}

extension WeatherDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = tableView.frame.size.width
        let aspectRatio: CGFloat = 414 / 80
        return width / aspectRatio
    }

//    // MARK: - Navigation
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}
