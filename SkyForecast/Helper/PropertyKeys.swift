//
//  PropertyKeys.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/20/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

struct PropertyKeys {
    
    static let baseURL = "https://api.darksky.net/forecast/"
    
    static let sbIdLocationListVC = "LocationListViewController"
    static let sbIdForecastListVC = "ForecastListViewController"
    static let sbIdForecastVC = "ForecastViewController"
    
    static let locationCellIdentifier = "LocationCellID"
    static let locationSelectionTitle = "Select a Location"
    
    static let forecastCurrently = "Current Weather"
    static let forecastHourly = "24-Hour Forecast"
    static let forecastDaily = "7-Day Forecast"
    static let forecastCellIdentifier = "ForecastCellID"
    static let forecastSelectionTitle = "Select a Forecast"
    
    static let segueSelectForecast = "selectForecastSegue"
    static let segueShowForecast = "showForecastSegue"
    
}
