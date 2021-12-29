//
//  WeatherViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 25.11.2021.
//

import UIKit

final class WeatherViewController: BaseViewController {

    @IBOutlet private weak var upperStackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionImage: UIImageView!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!

    @IBOutlet private weak var forecastCollectionView: UICollectionView!

    @IBOutlet private weak var detailView: UIView!
    @IBOutlet private weak var detailStackView: UIStackView!

    private var upperActivityIndicator = UIActivityIndicatorView()
    private var middleActivityIndicator = UIActivityIndicatorView()
    private var lowerActivityIndicator = UIActivityIndicatorView()

    private var forecastDataSource = [Forecast]()

    private var cityWeather: CityWeather?
    private var stackView1 = UIStackView()
    private var stackView2 = UIStackView()
    private var stackView3 = UIStackView()

    private let aspectRatioToView: CGFloat = 8
    private let heightCellLessCollection = 0.5

    private let settingsManager = SettingsManager.shared
    private let userDataManager = UserDataManager.shared
    private let weatherDateFormatter = WeatherDateFormatter.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        startViewScreen(title: "Weather")
        setupForecastCollectionView()
        addActivityIndicators()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let cityWeather = cityWeather else { return }

        reloadDataFromUpperStackView(cityWeather: cityWeather)
        forecastCollectionView.reloadData()
        reloadDetailStackView(cityWeather: cityWeather)
    }

    // MARK: - Start view screen
    override func startViewScreen(title: String) {
        super.startViewScreen(title: title)
        clearLabels()
    }

    private func clearLabels() {
        nameLabel.text = ""
        weatherDescriptionLabel.text = ""
        dateLabel.text = ""
        tempLabel.text = ""
        sunriseLabel.text = ""
        sunsetLabel.text = ""
    }

    // MARK: - ForecastCollectionView
    private func setupForecastCollectionView() {
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self

        forecastCollectionView.register(cell: ForecastCollectionViewCell.self)
    }

    // MARK: - ActivityIndicators
    private func addActivityIndicators() {
        upperStackView.addSubview(upperActivityIndicator)
        setupActivityIndicator(activityIndicator: upperActivityIndicator)

        forecastCollectionView.addSubview(middleActivityIndicator)
        setupActivityIndicator(activityIndicator: middleActivityIndicator)

        detailStackView.addSubview(lowerActivityIndicator)
        setupActivityIndicator(activityIndicator: lowerActivityIndicator)
    }

    private func setupActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let xConstraint = NSLayoutConstraint(item: activityIndicator,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: activityIndicator.superview,
                                             attribute: .centerX,
                                             multiplier: 1,
                                             constant: 0)

        let yConstraint = NSLayoutConstraint(item: activityIndicator,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: activityIndicator.superview,
                                             attribute: .centerY,
                                             multiplier: 1,
                                             constant: 0)

        NSLayoutConstraint.activate([xConstraint, yConstraint])

        activityIndicator.hidesWhenStopped = true
    }

    private func startActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func stopActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.isHidden = true
    }

    private func startAllActivityIndicators() {
        [upperActivityIndicator, middleActivityIndicator, lowerActivityIndicator].forEach {
            startActivityIndicator(activityIndicator: $0)
        }
    }

    private func stopAllActivityIndicators() {
        [upperActivityIndicator, middleActivityIndicator, lowerActivityIndicator].forEach {
            stopActivityIndicator(activityIndicator: $0)
        }
    }

    // MARK: - Downloading data from the internet (NetworkManager)
    private func loadData() {
        startAllActivityIndicators()

        NetworkManager.shared.callForecastCityWeatherRequest(cityNameString: "Kharkov") { [weak self] (cityWeather) in
            guard let cityWeather = cityWeather else { return }

            DispatchQueue.main.async {
                self?.setupUpperStackView(cityWeather: cityWeather)
                self?.cityWeather = cityWeather

                self?.forecastDataSource = cityWeather.forecasts
                self?.forecastCollectionView.reloadData()

                self?.saveForecastDays(forecasts: cityWeather.forecasts)

                self?.setupDetailStackView(cityWeather: cityWeather)

                self?.stopAllActivityIndicators()
            }
        }
    }

    // MARK: - func for TopStackView
    private func setupUpperStackView(cityWeather: CityWeather) {
        nameLabel.text = cityWeather.name
        weatherDescriptionImage.image = ImageWeather.shared
            .getImageWeather(weatherDescriptionString: cityWeather.weatherDescription)
        weatherDescriptionLabel.text = cityWeather.weatherDescription
        dateLabel.text = weatherDateFormatter.getDateStringFromDate(date: cityWeather.date)
        reloadDataFromUpperStackView(cityWeather: cityWeather)

        [nameLabel, weatherDescriptionLabel, dateLabel, tempLabel].forEach {
            LabelFormatter.shared.setupLabelSizeFont(label: $0)
        }
    }

    private func reloadDataFromUpperStackView(cityWeather: CityWeather) {
        tempLabel.text = settingsManager.getUnitSelectedFormat(celsius: cityWeather.temp)

        sunriseLabel.text = settingsManager.getHourWithMinutesSelectedFormat(hourTwentyFour:
                                    weatherDateFormatter.getHourWithMinutesStringFromDate(date: cityWeather.sunrise))
        sunsetLabel.text = settingsManager.getHourWithMinutesSelectedFormat(hourTwentyFour:
                                    weatherDateFormatter.getHourWithMinutesStringFromDate(date: cityWeather.sunset))
    }

    // MARK: - save ForecastDays in
    private func saveForecastDays(forecasts: [Forecast]) {
        var forecastDays = [ForecastDayModel]()

        forecasts.forEach {
            let hour = weatherDateFormatter.getHourStringFromDate(date: $0.time)
            if hour.elementsEqual("11") {
                let forecastDay = ForecastDayModel(day: weatherDateFormatter.getDayStringFromDate(date: $0.time),
                                                   temp: $0.temp,
                                                   weatherIcon: $0.weatherDescription)
                forecastDays.append(forecastDay)
            }
        }
        userDataManager.saveForecastDaysInUserDefaults(forecastDays: forecastDays)
    }

    // MARK: - func for DetailStackView
    private func setupDetailStackView(cityWeather: CityWeather) {
        stackView1 = getCustomStackViewForDetailView()
        stackView2 = getCustomStackViewForDetailView()
        stackView3  = getCustomStackViewForDetailView()

        reloadDetailStackView(cityWeather: cityWeather)
    }

    private func getCustomStackViewForDetailView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }

    private func reloadDetailStackView(cityWeather: CityWeather) {
        clearDetailStackView()

        var settingDetailsOnArray = [SettingDetailsModel]()
        settingsManager.getSettingDetails().forEach { settingDetailsModel in
            if settingDetailsModel.isOn {
                settingDetailsOnArray.append(settingDetailsModel)
            }
        }

        settingDetailsOnArray.enumerated().forEach {
            let nameParameter = $1.detailParameter.rawValue
            let valueParameter = getValueParameterByName(nameParameter: nameParameter, cityWeather: cityWeather)

            let detailItem = WeatherDetailItem.init(name: nameParameter, value: valueParameter)
            let detailModel = WeatherDetailViewModel.init(weatherDetailItem: detailItem)
            let view = getWeatherDetailView(weatherDetailViewModel: detailModel)
            addWeatherDetailViewOnStackView(view: view, index: $0)
        }
        showFilledStackViews(countViews: settingDetailsOnArray.count)
    }

    private func clearDetailStackView() {
        clearStackView(stackView: stackView1)
        clearStackView(stackView: stackView2)
        clearStackView(stackView: stackView3)

        clearStackView(stackView: detailStackView)
    }

    private func clearStackView(stackView: UIStackView) {
        stackView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }

    private func getValueParameterByName(nameParameter: String, cityWeather: CityWeather) -> String {
        var valueParameter = ""
        switch nameParameter {
        case "Humidity": valueParameter = String(cityWeather.humidity) + "%"
        case "Wind Speed": valueParameter = settingsManager.getDistanceSelectedFormat(metre: cityWeather.windSpeed)
        case "Min Temp": valueParameter = settingsManager.getUnitSelectedFormat(celsius: cityWeather.tempMin)
        case "Max Temp": valueParameter = settingsManager.getUnitSelectedFormat(celsius: cityWeather.tempMax)
        case "Feels Like": valueParameter = settingsManager.getUnitSelectedFormat(celsius: cityWeather.feelsLike)
        case "Pressure": valueParameter = String(Int(round(cityWeather.pressure)))
        default: break
        }
        return valueParameter
    }

    private func getWeatherDetailView(weatherDetailViewModel: WeatherDetailViewModel) -> WeatherDetailView {
        let detailView = WeatherDetailView.fromNib(named: String(describing: WeatherDetailView.self))
        detailView.setup(weatherDetailViewModel: weatherDetailViewModel)

        let heightForView = view.frame.size.height / aspectRatioToView
        detailView.heightAnchor.constraint(equalToConstant: heightForView).isActive = true
        return detailView
    }

    private func addWeatherDetailViewOnStackView(view: WeatherDetailView, index: Int) {
        switch index {
        case 0...1: stackView1.addArrangedSubview(view)
        case 2...3: stackView2.addArrangedSubview(view)
        case 4...5: stackView3.addArrangedSubview(view)
        default: break
        }
    }

    private func showFilledStackViews(countViews: Int) {
        detailView.isHidden = countViews == 0

        switch countViews {
        case 1...2:
            detailStackView.addArrangedSubview(stackView1)
        case 3...4:
            detailStackView.addArrangedSubview(stackView1)
            detailStackView.addArrangedSubview(stackView2)
        case 5...6:
            detailStackView.addArrangedSubview(stackView1)
            detailStackView.addArrangedSubview(stackView2)
            detailStackView.addArrangedSubview(stackView3)
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastDataSource.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ForecastCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        var forecastViewModel = ForecastViewModel(forecast: forecastDataSource[indexPath.row])
        forecastViewModel.time = settingsManager.getHourSelectedFormat(hourTwentyFour: forecastViewModel.time)
        forecastViewModel.temp = settingsManager.getUnitSelectedFormat(celsius: forecastDataSource[indexPath.row].temp)

        cell.setup(forecastViewModel: forecastViewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WeatherViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.size.height / aspectRatioToView) - heightCellLessCollection
        let aspectRatio: CGFloat = 150 / 250
        let width = height * aspectRatio
        return CGSize(width: width, height: height)
    }
}
