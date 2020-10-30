//
//  TripDetailViewController.swift
//  PA6
//
//  Created by user180005 on 10/29/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//

import UIKit

class TripDetailViewController: UIViewController {

    var tripOptional: Trip? = nil
    
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let trip = tripOptional {
            destinationLabel.text = trip.destinationName
            startDateLabel.text = trip.startDate
            endDateLabel.text = trip.endDate
        }
    }
    
    /*
    // MARK: - Navigation
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        */
    
}
