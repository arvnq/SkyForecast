//
//  Forecast.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/22/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

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
