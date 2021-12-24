//
//  AddLocationViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 22.12.2021.
//

import UIKit
import MapKit

final class AddLocationViewController: BaseViewController {

    @IBOutlet private weak var mapView: MKMapView!

    var resultSearchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        setupLocationSearchTableVC()
        setupSearchBar()
        setupResultSearchController()
//        locationSearchViewController.mapView = mapView

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

    private func changeSaveBarButtonItemStatus() {
        guard let right = navigationItem.rightBarButtonItem else { return }

        right.isEnabled = !right.isEnabled
    }

    private func setupLocationSearchTableVC() {
        // TODO: remove Strings
        let storyboard = UIStoryboard(name: "LocationSearchViewController", bundle: nil)
        guard let locationSearchViewController = storyboard.instantiateViewController(
            withIdentifier: "LocationSearchViewController") as? LocationSearchViewController else { return }

        resultSearchController = UISearchController(searchResultsController: locationSearchViewController)
        resultSearchController?.searchResultsUpdater = locationSearchViewController

        locationSearchViewController.mapView = mapView
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
        longPressGesture.delegate = self
        self.mapView.addGestureRecognizer(longPressGesture)
    }

    // MARK: - @objc funcs
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        } else if gestureRecognizer.state != UIGestureRecognizer.State.began {
            let touchPoin = gestureRecognizer.location(in: mapView)

            let touchMapCoordinate = mapView.convert(touchPoin, toCoordinateFrom: mapView)
            print("touchMapCoordinate: \(touchMapCoordinate)")

            // TODO: work with CLLocationCoordinate2D
        }
    }

    @objc private func clickCancelBarButtonItem() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func clickSaveBarButtonItem() {
        // TODO: add func Save location
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension AddLocationViewController: UIGestureRecognizerDelegate {

}
