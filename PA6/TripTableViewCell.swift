//
//  TripTableViewCell.swift
//  PA7
//
//  Created by Kevin Lunden on 10/29/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//
import UIKit

// Class that dictates what is shown within an individual trip cell
class TripTableViewCell: UITableViewCell {

    // Creates labels for destination and dates
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var tripImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Dispays the trip title and dates within the cell
    func update(with trip: Trip) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if let startDate = trip.startDate, let endDate = trip.endDate {
            let startDateString = dateFormatter.string(from: startDate)
            let endDateString = dateFormatter.string(from: endDate)
            dateLabel.text = "\(startDateString) - \(endDateString)"
        }
        
        destinationLabel.text = trip.destinationName
        
        if let image = trip.imageFileName {
            tripImageView.image = UIImage(contentsOfFile: image)
        }
    }

}
