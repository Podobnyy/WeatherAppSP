//
//  LocationSearchTableVC.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 22.12.2021.
//

import UIKit

class LocationSearchTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .init(red: 120/255, green: 120/255, blue: 240/255, alpha: 1)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

// MARK: - UISearchResultsUpdating
extension LocationSearchTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
