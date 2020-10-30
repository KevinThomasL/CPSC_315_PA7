//
//  Trip.swift
//  PA6
//
//  Created by user180005 on 10/27/20.
//  Copyright © 2020 Kevin Lunden. All rights reserved.
//

import Foundation

// summertime.png author credit:
// <div>Icons made by <a href="https://www.flaticon.com/authors/mangsaabguru" title="mangsaabguru">mangsaabguru</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>


// Struct that represents an indivudal trip
struct Trip: CustomStringConvertible {
    var destinationName: String
    var startDate: String
    var endDate: String
    var imageName: String
    var description: String {
        return "description"
    }
    
    // Initializes variables of trip struct
    init(destinationName: String, startDate: String, endDate: String, imageFileName: String?) {
        self.destinationName = destinationName
        self.startDate = startDate
        self.endDate = endDate
        self.imageName = "summertime"
    }
    
}
