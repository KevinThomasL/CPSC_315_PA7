//
//  ViewController.swift
//  PA6
//
//  Created by user180005 on 10/27/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//
import UIKit

// Class that controls the trip table, first screen
class TripTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Creates an empty trip array
    var trips = [Trip]()

    // Creates a tableview outlet
    @IBOutlet var tableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    // Upon loading will add trips to trips array
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTrips()
    }
    
    // Function that adds first predetermined trips to array
    func initializeTrips() {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let today = Date()
        let todayStr = dateFormatter.string(from: today)
        
        trips.append(Trip(destinationName: "Hawaii", startDate: "07/23/2020", endDate: "07/29/2020", imageName: "summertime"))
        trips.append(Trip(destinationName: "Paris", startDate: "07/24/2020", endDate: "08/03/2020", imageName: "summertime"))
        trips.append(Trip(destinationName: "London", startDate: "08/04/2020", endDate: "08/10/2020", imageName: "summertime"))
        trips.append(Trip(destinationName: "Berlin", startDate: "09/21/2020", endDate: "09/28/2020", imageName: "suitcases"))
        trips.append(Trip(destinationName: "Dubai", startDate: "11/22/2020", endDate: "11/29/2020", imageName: "suitcases"))
    }
    
    // Function that returns amount of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return trips.count
        }
        return 0
    }
    
    // Function that determins what cell to display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let trip = trips[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripTableViewCell
        
        cell.update(with: trip)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let trip = trips.remove(at: sourceIndexPath.row)
        trips.insert(trip, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        trips.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .fade)
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
            else if identifier == "AddSegue" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            }
        }
    }
    
    @IBAction func unwindToTripTableViewController(segue: UIStoryboardSegue) {
            if let identifier = segue.identifier {
                if identifier == "SaveSegue" {
                    if let addTripVC = segue.source as? AddTripViewController {
                        if let trip = addTripVC.tripOptional {
                            // get the currently selected index path
                            if let indexPath = tableView.indexPathForSelectedRow {
                                trips[indexPath.row] = trip
                            }
                            else {
                                trips.append(trip)
                            }
                            // force update the table view
                            tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        let newEditingMode = !tableView.isEditing
        tableView.setEditing(newEditingMode, animated: true)
    }
    
}
