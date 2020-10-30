//
//  AddTripViewController.swift
//  PA6
//
//  Created by user180005 on 10/30/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {

    var tripOptional: Trip? = nil
    
    @IBOutlet var destinationTextField: UITextField!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let trip = tripOptional {
            destinationTextField.text = trip.destinationName
            startDateTextField.text = trip.startDate
            endDateTextField.text = trip.endDate
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "AddSegue" {
                if let destination = destinationTextField.text, let startDate = startDateTextField.text, let endDate = endDateTextField.text {
                    tripOptional = Trip(destinationName: destination, startDate: startDate, endDate: endDate, imageFileName: nil)
                }
            }
        }
    }
    

}
