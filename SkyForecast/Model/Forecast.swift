//
//  Forecast.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/22/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

/**
 this is the object structure for a normal forecast. The blueprint of the forecast being displayed on screen
 */
struct Forecast: Equatable, Codable {
    var location: Location
    var forecastFrequency: FrequencyForecast?
    var completeForecast: CompleteForecast?
    var isFavourite: Bool = false
    
    mutating func toggleFavourite() {
        isFavourite = !isFavourite
    }
    
    static func ==(lhs: Forecast, rhs: Forecast) -> Bool {
        return lhs.location == rhs.location && lhs.forecastFrequency == rhs.forecastFrequency
    }
    
}
