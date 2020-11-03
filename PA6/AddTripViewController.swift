//
//  AddTripViewController.swift
//  PA6
//
//  Created by user180005 on 10/30/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//
import UIKit

class AddTripViewController: UIViewController, UITextFieldDelegate {

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
        
        destinationTextField.delegate = self
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        var inputFlag = false
        if let identifier = segue.identifier {
            if identifier == "SaveSegue" {
                inputFlag = destinationInputCheck()
                if inputFlag == false, let destination = destinationTextField.text, let startDate = startDateTextField.text, let endDate = endDateTextField.text {
                    tripOptional = Trip(destinationName: destination, startDate: startDate, endDate: endDate, imageName: nil)
                }
            }
        }
    }
    
    func destinationInputCheck() -> Bool {
        if let text = destinationTextField.text, text.isEmpty {
            let alertController = UIAlertController(title: "Destination Input Alert", message: "Missing Destination", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
            return true
        }
        return false
    }
    
    func startDateInputCheck() {
        let alertController = UIAlertController(title: "Start Date Input Alert", message: "Invalid Start Date Entered", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func endDateInputCheck() {
        let alertController = UIAlertController(title: "End Date Input Alert", message: "Invalid End Date Entered", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        destinationTextField.resignFirstResponder()
        startDateTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
        return true
    }
    
    @objc func handleTap() {
        destinationTextField.resignFirstResponder()
        startDateTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
    }
    
}
