//
//  AddLocationViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 22.12.2021.
//

import UIKit
import MapKit

final class AddLocationViewController: BaseViewController {

    @IBOutlet private weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var searchNavigationBar: UINavigationBar!
    @IBOutlet private weak var mapView: MKMapView!

    var resultSearchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()

        changeSaveBarButtonItemStatus()
        setupLocationSearchTableVC()
        setupSearchBar()
        setupLongPressGesture()
    }

    // MARK: - funcs
    private func changeSaveBarButtonItemStatus() {
        saveBarButtonItem.isEnabled = !saveBarButtonItem.isEnabled
    }

    private func setupLocationSearchTableVC() {
        // TODO: remove Strings
        let storyboard = UIStoryboard(name: "LocationSearchTableVC", bundle: nil)
        let locationSearchTableVC = storyboard.instantiateViewController(
            withIdentifier: "LocationSearchTableVC") as? LocationSearchTableVC
        resultSearchController = UISearchController(searchResultsController: locationSearchTableVC)
        resultSearchController?.searchResultsUpdater = locationSearchTableVC
    }

    private func setupSearchBar() {
        guard let resultSearchController = resultSearchController else { return }

        let searchBar = resultSearchController.searchBar
        searchBar.sizeToFit()
        searchBar.tintColor = .white
        searchBar.placeholder = "Search for location"
        searchNavigationBar.items?.first?.titleView = searchBar
    }

    private func setupLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 1
        longPressGesture.delaysTouchesBegan = true
        longPressGesture.delegate = self
        self.mapView.addGestureRecognizer(longPressGesture)
    }

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

    // MARK: - IBActions
    @IBAction private func clickCancelBarButtonItem(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func clickSaveBarButtonItem(_ sender: UIBarButtonItem) {
        // TODO: add func Save location
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension AddLocationViewController: UIGestureRecognizerDelegate {

}
