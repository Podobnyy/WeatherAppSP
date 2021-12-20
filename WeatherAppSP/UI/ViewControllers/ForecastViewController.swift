//
//  ForecastViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 20.12.2021.
//

import UIKit

class ForecastViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var tableViewDataSource = [ForecastDayModel]()

    private let settingsManager = SettingsManager.shared
    private let userDataManager = UserDataManager.shared
    private let imageWeather = ImageWeather.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        startViewScreen(title: "Forecast Days")
        setupTableView()

        tableViewDataSource = userDataManager.getForecastDaysFromUserDefaults() ?? [ForecastDayModel]()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.dataSource = self

        tableView.register(cell: ForecastDayTableViewCell.self)
    }
}

// MARK: - UITableViewDataSource

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ForecastDayTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        let forecastDay = tableViewDataSource[indexPath.row]

        let forecastDayViewModel = ForecastDayViewModel(
            day: forecastDay.day,
            temp: settingsManager.getUnitSelectedFormat(celsius: forecastDay.temp),
            weatherIcon: imageWeather.getImageWeather(weatherDescriptionString: forecastDay.weatherIcon)
        )

        cell.setup(forecastDayViewModel: forecastDayViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ForecastViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = tableView.frame.size.width
        return width / Constants.aspectRatio
    }
}

private enum Constants {
    static let aspectRatio: CGFloat = 414 / 80
}
