//
//  LocationsViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 21.12.2021.
//

import Foundation
import UIKit

final class LocationsViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!

    private var cityArray = [String]()
    private var tableViewDataSource = [CurrentWeatherModel]()

    private let imageWeather = ImageWeather.shared
    private let settingsManager = SettingsManager.shared
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        startViewScreen(title: "Locations")

        setupTableView()
        setupTableViewDataSource()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func startViewScreen(title: String) {
        super.startViewScreen(title: title)
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }

    // MARK: - TableView
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(cell: LocationTableViewCell.self)
    }

    private func setupTableViewDataSource() {
        cityArray = ["Kharkov", "Kyiv", "Dnipro"]
    }

    // MARK: - Downloading data from the internet (NetworkManager)
    private func loadData() {
        cityArray.forEach {
            networkManager.callCurrentWeatherRequest(cityNameString: $0) { [weak self] (currentWeather) in
                guard let currentWeather = currentWeather else { return }

                DispatchQueue.main.sync {
                    self?.tableViewDataSource.append(currentWeather)
                    self?.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - IBActions
    @IBAction func clickAddButton(_ sender: UIButton) {
        // TODO: remove Strings
        let storyboard = UIStoryboard(name: "AddLocationViewController", bundle: nil)
        let addLocationVC = storyboard.instantiateViewController(withIdentifier: "AddLocationViewController")
        self.present(addLocationVC, animated: true)
    }

}

// MARK: - UITableViewDataSource
extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        let currentWeatherModel = tableViewDataSource[indexPath.row]
        let locationViewModel = LocationViewModel(
            name: currentWeatherModel.name,
            temp: settingsManager.getUnitSelectedFormat(celsius: currentWeatherModel.temp),
            weatherIcon: UIImage(named: currentWeatherModel.iconString) ?? UIImage())
        cell.setup(locationViewModel: locationViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LocationsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.width / Constants.aspectRatioTableViewCells
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

enum Constants {
    static let aspectRatioTableViewCells: CGFloat = 414 / 80
}
