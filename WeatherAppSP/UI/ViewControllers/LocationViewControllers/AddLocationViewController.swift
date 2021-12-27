//
//  AddLocationViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 22.12.2021.
//

import UIKit
import MapKit

protocol AddLocationViewControllerDelegate: AnyObject {
    func addLocationViewController(location: LocationModel)
}

final class AddLocationViewController: BaseViewController {

    @IBOutlet private weak var mapView: MKMapView!

    weak var delegate: AddLocationViewControllerDelegate?

    let locationManager = CLLocationManager()
    var resultSearchController: UISearchController?

    var selectedPin: MKPlacemark?
    var selectedLocation: LocationModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        setupLocationManager()
        setupLocationSearchTableVC()
        setupSearchBar()
        setupResultSearchController()

        setupLongPressGesture()
    }

    // MARK: - funcs
    private func setupNavigationBar() {
        let left = UIBarButtonItem(title: "Cancel",
                                   style: .plain,
                                   target: self,
                                   action: #selector(self.clickCancelBarButtonItem))
        left.tintColor = .white
        navigationItem.leftBarButtonItem = left

        let right = UIBarButtonItem(title: "Save",
                                    style: .plain,
                                    target: self,
                                     action: #selector(self.clickSaveBarButtonItem))
        right.tintColor = .white
        right.isEnabled = false
        navigationItem.rightBarButtonItem = right
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    private func setupLocationSearchTableVC() {
        // TODO: remove Strings
        let storyboard = UIStoryboard(name: "LocationSearchViewController", bundle: nil)
        guard let locationSearchViewController = storyboard.instantiateViewController(
            withIdentifier: "LocationSearchViewController") as? LocationSearchViewController else { return }

        resultSearchController = UISearchController(searchResultsController: locationSearchViewController)
        resultSearchController?.searchResultsUpdater = locationSearchViewController

        locationSearchViewController.mapView = mapView

        locationSearchViewController.handleMapSearchDelegate = self
    }

    private func setupSearchBar() {
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        searchBar?.tintColor = .white
        searchBar?.placeholder = "Search for location"

        navigationItem.searchController = resultSearchController
    }

    private func setupResultSearchController() {
        definesPresentationContext = true
    }

    private func setupLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 1
        longPressGesture.delaysTouchesBegan = true
        self.mapView.addGestureRecognizer(longPressGesture)
    }

    private func updateSelectedLocation(coordinate: CLLocationCoordinate2D) {
        let location = LocationModel.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
        selectedLocation = location
        isSelectedLocation()
    }

    private func isSelectedLocation() {
        guard let right = navigationItem.rightBarButtonItem else { return }

        if (right.isEnabled == false) && (selectedLocation != nil) {
            right.isEnabled = true
        }
    }

    // MARK: - @objc funcs
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        } else if gestureRecognizer.state != UIGestureRecognizer.State.began {
            let touchPoin = gestureRecognizer.location(in: mapView)

            let touchMapCoordinate = mapView.convert(touchPoin, toCoordinateFrom: mapView)

            dropPinZoomIn(placemark: MKPlacemark(coordinate: touchMapCoordinate))
        }
    }

    @objc private func clickCancelBarButtonItem() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func clickSaveBarButtonItem() {
        guard let selectedLocation = selectedLocation else { return }

        delegate?.addLocationViewController(location: selectedLocation)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: CLLocationManagerDelegate
extension AddLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: Constants.sizeSpan, longitudeDelta: Constants.sizeSpan)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

// MARK: - HandleMapSearch
extension AddLocationViewController: HandleMapSearch {

    func dropPinZoomIn(placemark: MKPlacemark) {
        selectedPin = placemark                         // cache the pin
        mapView.removeAnnotations(mapView.annotations)  // clear existing pins

        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality, let state = placemark.administrativeArea {
            annotation.subtitle = city + ", " + state
        }
        mapView.addAnnotation(annotation)

        let span = MKCoordinateSpan(latitudeDelta: Constants.sizeSpan, longitudeDelta: Constants.sizeSpan)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)

        updateSelectedLocation(coordinate: placemark.coordinate)
    }
}
