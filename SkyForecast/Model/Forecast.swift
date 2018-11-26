//
//  Forecast.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/22/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    var location: Location
    var forecastFrequency: FrequencyForecast?
    var completeForecast: CompleteForecast?
    var isFavourite: Bool = false
    
    mutating func toggleFavourite() {
        isFavourite = !isFavourite
    }
}
