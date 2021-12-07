//
//  WeatherViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 25.11.2021.
//

import UIKit

class WeatherViewController: BaseViewController {

    @IBOutlet private weak var upperStackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionImage: UIImageView!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var sunsetLabel: UILabel!

    @IBOutlet private weak var forecastCollectionView: UICollectionView!

    @IBOutlet private weak var detailStackView: UIStackView!

    private var upperActivityIndicator = UIActivityIndicatorView()
    private var middleActivityIndicator = UIActivityIndicatorView()
    private var lowerActivityIndicator = UIActivityIndicatorView()

    private var forecastDataSource = [Forecast]()

    private let aspectRatioToView: CGFloat = 8
    private let heightCellLessCollection = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()

        startViewScreen(title: "Weather")
        setupForecastCollectionView()
        addActivityIndicators()
        loadData()
    }

    // MARK: - Start view screen
    override func startViewScreen(title: String) {
        super.startViewScreen(title: title)
        clearLabel()
    }

    private func clearLabel() {
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

        forecastCollectionView.register(UINib(nibName: "ForecastCollectionViewCell", bundle: nil),
                                        forCellWithReuseIdentifier: "ForecastCollectionViewCell")
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

    // MARK: - NetworkManager
    private func loadData() {
        startAllActivityIndicators()

        NetworkManager.shared.callCityWeatherRequest(cityNameString: "Kharkov") { [weak self] (cityWeather) in
            guard let cityWeather = cityWeather else { return }

            DispatchQueue.main.async {
                self?.setupUpperStackView(cityWeather: cityWeather)

                self?.forecastDataSource = cityWeather.forecasts
                self?.forecastCollectionView.reloadData()

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
        dateLabel.text = WeatherDateFormatter.shared.getDateStringFromDate(date: cityWeather.date)
        tempLabel.text = "\(cityWeather.temp)°"
        sunriseLabel.text = WeatherDateFormatter.shared.getTimeStringFromDate(date: cityWeather.sunrise)
        sunsetLabel.text = WeatherDateFormatter.shared.getTimeStringFromDate(date: cityWeather.sunset)

        [nameLabel, weatherDescriptionLabel, dateLabel, tempLabel].forEach {
            LabelFormatter.shared.setupLabelSizeFont(label: $0)
        }
    }

    // MARK: - func for DetailStackView
    private func setupDetailStackView(cityWeather: CityWeather) {
        let stackView1 = getCustomStackViewForDetailView()
        let stackView2 = getCustomStackViewForDetailView()
        let stackView3 = getCustomStackViewForDetailView()

        let humidityItem = WeatherDetailItem.init(name: "Humidity", value: cityWeather.humidity)
        let windSpeedItem = WeatherDetailItem.init(name: "Wind Speed", value: cityWeather.windSpeed)
        let tempMinItem = WeatherDetailItem.init(name: "Min Temp", value: cityWeather.tempMin)
        let tempMaxItem = WeatherDetailItem.init(name: "Max Temp", value: cityWeather.tempMax)
        let feelsLikeItem = WeatherDetailItem.init(name: "Feels Like", value: cityWeather.feelsLike)
        let pressureItem = WeatherDetailItem.init(name: "Pressure", value: cityWeather.pressure)

        let humidityModel = WeatherDetailModel.init(weatherDetailItem: humidityItem)
        let windSpeedModel = WeatherDetailModel.init(weatherDetailItem: windSpeedItem)
        let tempMinModel = WeatherDetailModel.init(weatherDetailItem: tempMinItem)
        let tempMaxModel = WeatherDetailModel.init(weatherDetailItem: tempMaxItem)
        let feelsLikeModel = WeatherDetailModel.init(weatherDetailItem: feelsLikeItem)
        let pressureModel = WeatherDetailModel.init(weatherDetailItem: pressureItem)

        let view1 = getWeatherDetailView(weatherDetailModel: humidityModel)
        let view2 = getWeatherDetailView(weatherDetailModel: windSpeedModel)
        let view3 = getWeatherDetailView(weatherDetailModel: tempMinModel)
        let view4 = getWeatherDetailView(weatherDetailModel: tempMaxModel)
        let view5 = getWeatherDetailView(weatherDetailModel: feelsLikeModel)
        let view6 = getWeatherDetailView(weatherDetailModel: pressureModel)

        stackView1.addArrangedSubview(view1)
        stackView1.addArrangedSubview(view2)
        stackView2.addArrangedSubview(view3)
        stackView2.addArrangedSubview(view4)
        stackView3.addArrangedSubview(view5)
        stackView3.addArrangedSubview(view6)

        detailStackView.addArrangedSubview(stackView1)
        detailStackView.addArrangedSubview(stackView2)
        detailStackView.addArrangedSubview(stackView3)
  //      detailStackView.isHidden = true
    }

    private func getCustomStackViewForDetailView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }

    private func getWeatherDetailView(weatherDetailModel: WeatherDetailModel) -> WeatherDetailView {
        let view = WeatherDetailView.fromNib(named: "WeatherDetailView")
        view.setup(weatherDetailModel: weatherDetailModel)

        let heightForView = view.frame.size.height / aspectRatioToView
        view.heightAnchor.constraint(equalToConstant: heightForView).isActive = true
        return view
    }
}

// MARK: - Extensions
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
        let forecastViewModel = ForecastViewModel(forecast: forecastDataSource[indexPath.row])
        cell.setup(forecastViewModel: forecastViewModel)
        return cell
    }
}

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
