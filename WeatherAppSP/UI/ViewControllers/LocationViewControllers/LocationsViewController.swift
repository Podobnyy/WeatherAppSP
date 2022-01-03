import UIKit

final class LocationsViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!

    private var locationsArray = [LocationModel]()
    private var tableViewDataSource = [CurrentWeatherModel]()

    private let imageWeather = ImageWeather.shared
    private let settingsManager = SettingsManager.shared
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        startViewScreen(title: "Locations")

        setupTableView()
        setupTableViewDataSource()
        loadWeatherDataForLocationByAllLocations()
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
        locationsArray = [LocationModel(latitude: 49.9903398, longitude: 36.2326905),
                          LocationModel(latitude: 50.4461248, longitude: 30.5214979),
                          LocationModel(latitude: 48.4671206, longitude: 35.0405817)]
    }

    // MARK: - Downloading data from the internet (NetworkManager)
    private func loadWeatherDataForLocationByAllLocations() {
        locationsArray.forEach {
            loadWeatherDataForLocation(location: $0)
        }
    }

    private func loadWeatherDataForLocation(location: LocationModel) {
        networkManager.callCurrentWeatherRequest(location: location) { [weak self] (currentWeather) in
            guard let currentWeather = currentWeather else { return }

            DispatchQueue.main.sync {
                self?.tableViewDataSource.append(currentWeather)
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - IBActions
    @IBAction private func clickAddButton() {
        let storyboard = UIStoryboard(name: "AddLocationViewController", bundle: nil)
        guard let addLocationVC: AddLocationViewController = storyboard.instantiateVC() else { return }

        addLocationVC.delegate = self
        let navigationController = UINavigationController(rootViewController: addLocationVC)
        present(navigationController, animated: true)
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
        return tableView.frame.size.width / TableCellViewConstants.tableViewCellHeightAspectRatio
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - AddLocationViewControllerDelegate
extension LocationsViewController: AddLocationViewControllerDelegate {
    func addLocationViewController(_ addLocationViewController: AddLocationViewController,
                                   didAdd location: LocationModel) {
        locationsArray.append(location)
        loadWeatherDataForLocation(location: location)
    }
}

// TODO: load Locations from UserDefaults
// TODO: Save new Location to UserDefaults
