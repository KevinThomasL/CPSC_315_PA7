//
//  TripDetailViewController.swift
//  PA6
//
//  Created by Kevin Lunden on 10/29/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//

import UIKit

// class that controls the trips details page
class TripDetailViewController: UIViewController {

    // Creates outlets for displaying trip details and creates a trip optional
    var tripOptional: Trip? = nil
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var tripImageView:UIImageView!
    
    // When loaded the screen will populate the labels with specific trip info
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let trip = tripOptional {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            if let destination = trip.destinationName {
                destinationLabel.text = "\(destination)"
            }
            if let startDate = trip.startDate as Date? {
                startDateLabel.text = "\(dateFormatter.string(from: startDate))"
            }
            if let endDate = trip.endDate as Date? {
                endDateLabel.text = "\(dateFormatter.string(from: endDate))"
            }
            if let imageName = trip.imageName {
                tripImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    /*
    // MARK: - Navigation
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        */
    
}
