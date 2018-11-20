//
//  WeatherForecast.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/20/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

struct WeatherForecast {
    let frequency: Frequency
    
    enum Frequency: String, CaseIterable {
        case currently, hourly, daily
    }
    
    static func forecastTitle(forFrequency frequency: Frequency) -> String {
        switch frequency {
            case .currently: return PropertyKeys.forecastCurrently
            case .hourly: return PropertyKeys.forecastHourly
            case .daily: return PropertyKeys.forecastDaily
        }
    }
}
