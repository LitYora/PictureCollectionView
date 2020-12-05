//
//  StationTableViewController.swift
//  PictureCollectionView
//
//  Created by Matvei  on 03.12.2020.
//

import UIKit

class StationTableViewController: UITableViewController {
    
    var stations = [MStations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellStation", for: indexPath)

//        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = stations[indexPath.row].name

        return cell
    }
}
