//
//  ForecastRequest.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/21/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

/**
 Represents the whole data forecast structure when retrieving for query string currently and daily.
 This containts the current forecast and the daily forecast block.
 */
struct CompleteForecast: Codable {
    let timezone: String
    let currently: CurrentDataForecast
    let daily: DailyForecast
    
}

/**
 This represents the block containing the daily data forecast.
 */
struct DailyForecast: Codable {
    let summary: String
    let icon: String
    let data: [DailyDataForecast]
    
    
}
