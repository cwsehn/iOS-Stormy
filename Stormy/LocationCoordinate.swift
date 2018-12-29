//
//  LocationCoordinate.swift
//  Stormy
//
//  Created by Chris William Sehnert on 12/29/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct LocationCoordinate {
    
    let latitude: Double
    let longitude: Double
}

extension LocationCoordinate: CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
    
    static var alcatrazIsland: LocationCoordinate {
        return LocationCoordinate(latitude: 37.8267, longitude: -122.4233)
    }
}
