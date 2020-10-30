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
            destinationLabel.text = trip.destinationName
            startDateLabel.text = trip.startDate
            endDateLabel.text = trip.endDate
            tripImageView.image = UIImage(named: trip.imageName)
        }
    }
    
    /*
    // MARK: - Navigation
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        */
    
}
