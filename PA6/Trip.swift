//
//  Trip.swift
//  PA6
//
//  Created by user180005 on 10/27/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//

import Foundation

// Struct that represents an indivudal trip
struct Trip: CustomStringConvertible {
    var destinationName: String
    var startDate: String
    var endDate: String
    var imageFileName: String?
    var description: String {
        return "description"
    }
    
    // Initializes variables of trip struct
    init(destinationName: String, startDate: String, endDate: String, imageFileName: String?) {
        self.destinationName = destinationName
        self.startDate = startDate
        self.endDate = endDate
        self.imageFileName = imageFileName
    }
    
}
