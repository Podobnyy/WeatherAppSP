//
//  LocationSearchViewController.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 23.12.2021.
//

import UIKit
import MapKit

final class LocationSearchViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
}

// MARK: - extension UISearchResultsUpdating
extension LocationSearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
              let searchBarText = searchController.searchBar.text else { return }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region

        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else { return }

            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

// MARK: - extension Table View Data Source
extension LocationSearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSearchCell") else {
            return UITableViewCell()
        }

        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = selectedItem.title
        return cell
    }
}
