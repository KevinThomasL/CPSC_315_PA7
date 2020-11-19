//
//  ViewController.swift
//  PA6
//
//  Created by user180005 on 10/27/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//
import UIKit
import CoreData

// Class that controls the trip table, first screen
class TripTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Creates an empty trip array
    var trips = [Trip]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    // Creates a tableview outlet
    @IBOutlet var tableView: UITableView!

    let dateFormatter = DateFormatter()
    
    // Upon loading will add trips to trips array
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        // print out the documents directory so we can see our database in Finder
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsDirectoryURL)
            
        loadTrips()
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
            
        let trip = trips[indexPath.row]

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
        
        if editingStyle == .delete {
            context.delete(trips[indexPath.row])
            trips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        saveTrips()
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
                    if let tripDetailVC = segue.source as? AddTripViewController {
                        if let destination = tripDetailVC.destinationName, let start = tripDetailVC.startDate, let end = tripDetailVC.endDate, let image = tripDetailVC.imageFileName  {
                            let newTrip = Trip(context: self.context)
                            
                            newTrip.destinationName = destination
                            newTrip.startDate = start
                            newTrip.endDate = end
                            newTrip.imageFileName = image
                            
                            trips.append(newTrip)
                        }
                        saveTrips()
                }
            }
        }
    }
        
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        let newEditingMode = !tableView.isEditing
        tableView.setEditing(newEditingMode, animated: true)
    }
        
    func saveTrips() {
        do {
            try context.save()
        }
        catch {
            print("Error saving trips")
        }
        tableView.reloadData()
    }
        
    // READ of CRUD
    func loadTrips() {
        // we need to make a "request" to get the Category objects
        // via the persistent container
        let request: NSFetchRequest<Trip> = Trip.fetchRequest()
        // with a sql SELECT statement we usually specify a WHERE clause if we want to filter rows from the table we are selecting from
        // if we want to filter, we need to add a "predicate" to our request... we will do this later for Items
        do {
            trips = try context.fetch(request)
        }
        catch {
            print("Error loading categories \(error)")
        }
        tableView.reloadData()
    }

    
}
