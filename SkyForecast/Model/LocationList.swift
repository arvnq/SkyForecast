//
//  Locations.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/20/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

/// List of preliminary locations together with their latitude and longitude
struct LocationList {
    var locations: [Location]
    
    init() {
        let sydney = Location(locationName: "Sydney", locationLatitude: -33.865, locationLongitude: 151.2094)
        let melbourne = Location(locationName: "Melbourne", locationLatitude: -37.8136, locationLongitude: 144.9631)
        let singapore = Location(locationName: "Singapore", locationLatitude: 1.2833, locationLongitude: 103.8333)
        let manila = Location(locationName: "Manila", locationLatitude: 14.5833, locationLongitude: 120.9667)
        let tokyo = Location(locationName: "Tokyo", locationLatitude: 35.6833, locationLongitude: 139.6833)
        let munich = Location(locationName: "Munich", locationLatitude: 48.1351, locationLongitude: 11.5820)
        let geneva = Location(locationName: "Geneva", locationLatitude: 46.204391, locationLongitude: 6.143158)
        let sacramento = Location(locationName: "Sacramento", locationLatitude: 38.5816, locationLongitude: -121.4944)
        let newyork = Location(locationName: "New York", locationLatitude: 40.7128, locationLongitude: -74.0060)
        let london = Location(locationName: "London", locationLatitude: 51.507351, locationLongitude: -0.127758)
        let barcelona = Location(locationName: "Barcelona", locationLatitude: 41.385063, locationLongitude: 2.173404)
        let paris = Location(locationName: "Paris", locationLatitude: 48.856613, locationLongitude: 2.352222)
        let brussels = Location(locationName: "Brussels", locationLatitude: 50.850346, locationLongitude: 4.351721)
        let buenosaires = Location(locationName: "Buenos Aires", locationLatitude: -34.603683, locationLongitude: -58.381557)
        let stPetersburg = Location(locationName: "St. Petersburg", locationLatitude: 59.934280, locationLongitude: 30.335098)
        let toronto = Location(locationName: "Toronto", locationLatitude: 43.653225, locationLongitude: -79.383186)
        let johannesburg = Location(locationName: "Johannesburg", locationLatitude: -26.201450, locationLongitude: 28.045490)
        let beijing = Location(locationName: "Beijing", locationLatitude: 39.904202, locationLongitude: 116.407394)
        let auckland = Location(locationName: "Auckland", locationLatitude: -36.848461, locationLongitude: 174.763336)
        let dubai = Location(locationName: "Dubai", locationLatitude: 25.204849, locationLongitude: 55.270782)
        
        locations = [sydney, melbourne, singapore, manila, tokyo, munich, geneva, sacramento, newyork, london, barcelona, paris, brussels, buenosaires, stPetersburg, toronto, johannesburg, beijing, auckland, dubai]
    }
}
