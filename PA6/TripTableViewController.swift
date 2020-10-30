//
//  ViewController.swift
//  PA6
//
//  Created by user180005 on 10/27/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//

import UIKit

class TripTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var trips = [Trip]()

    @IBOutlet var tableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTrips()
    }
    
    func initializeTrips() {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let today = Date()
        let todayStr = dateFormatter.string(from: today)
        
        trips.append(Trip(destinationName: "Hawaii", startDate: "07/23/2020", endDate: "07/29/2020", imageFileName: nil))
        trips.append(Trip(destinationName: "Paris", startDate: "07/24/2020", endDate: "08/03/2020", imageFileName: nil))
        trips.append(Trip(destinationName: "London", startDate: "08/04/2020", endDate: "08/10/2020", imageFileName: nil))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return trips.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let trip = trips[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripTableViewCell
        
        cell.update(with: trip)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "DetailSegue" {
                if let tripDetailVC = segue.destination as? TripDetailViewController {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        let trip = trips[indexPath.row]
                        tripDetailVC.tripOptional = trip
                    }
                }
            }
        }
    }
    
    @IBAction func unwindToTripTableViewController(segue: UIStoryboardSegue) {
            if let identifier = segue.identifier {
                if identifier == "SaveUnwindSegue" {
                    if let tripDetailVC = segue.source as? TripDetailViewController {
                        if let trip = tripDetailVC.tripOptional {
                            // get the currently selected index path
                            if let indexPath = tableView.indexPathForSelectedRow {
                                trips[indexPath.row] = trip
                                // force update the table view
                                tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
}

