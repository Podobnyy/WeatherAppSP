import UIKit

final class LocationsViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!

    private var listOfLocations = [LocationModel]()
    private var tableViewDataSource = [CurrentWeatherModel]()

    var networkManager: NetworkManager!
    var settingsManager: SettingsManager!
    var userDataManager: UserDataManager!

    var addLocation: (() -> Void)?
    var locationSelected: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        startViewScreen(title: "Locations")
        setupNavigationController()

        setupTableView()
        reloadListOfLocations()
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

    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - TableView
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(cell: LocationTableViewCell.self)
    }

    private func reloadListOfLocations() {
        listOfLocations = getListOfLocationsFromUserDefaults()
    }

    // MARK: - Downloading data from the internet (NetworkManager)
    private func loadWeatherDataForLocationByAllLocations() {
            listOfLocations.forEach {
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
        addLocation?()
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

    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userDataManager.setSelectedLocation(listOfLocations[indexPath.row])
        locationSelected?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - AddLocationViewControllerDelegate
extension LocationsViewController: AddLocationViewControllerDelegate {

    func addLocationViewController(_ addLocationViewController: AddLocationViewController,
                                   didAdd location: LocationModel) {
        listOfLocations.append(location)
        setListOfLocationsInUserDefaults(listOfLocations: listOfLocations)
        loadWeatherDataForLocation(location: location)
    }
}

// MARK: - UserDefaults
extension LocationsViewController {

    private func setListOfLocationsInUserDefaults(listOfLocations: [LocationModel]) {
        userDataManager.setListOfLocationsInUserDefaults(listOfLocations: listOfLocations)
    }

    private func getListOfLocationsFromUserDefaults() -> [LocationModel] {
        return userDataManager.getListOfLocationsFromUserDefaults() ?? [LocationModel]()
    }
}
