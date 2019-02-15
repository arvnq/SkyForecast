//
//  WeatherForecast.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/20/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

/**
 Returns the cases for current, hourly and daily forecast
 */
enum FrequencyForecast: String, CaseIterable, Codable {
        case currently, hourly, daily
        
        static func forecastTitle(forFrequency frequency: FrequencyForecast) -> String {
            switch frequency {
                case .currently: return PropertyKeys.forecastCurrently
                case .hourly: return PropertyKeys.forecastHourly
                case .daily: return PropertyKeys.forecastDaily
            }
        }
}
