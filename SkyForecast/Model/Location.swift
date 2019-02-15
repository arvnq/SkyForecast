//
//  Location.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/20/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

/// Represents the location object containing the name, latitude and longitude
struct Location: Equatable, Codable {
    let locationName: String
    let locationLatitude: Double
    let locationLongitude: Double

    init(locationName: String = "", locationLatitude: Double = 0.0, locationLongitude: Double = 0.0) {
        self.locationName = locationName
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
    }
    
}
