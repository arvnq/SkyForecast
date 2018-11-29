//
//  ForecastRequest.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/21/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

struct CompleteForecast: Codable {
    let timezone: String
    let currently: CurrentDataForecast
    let daily: DailyForecast
    
}


struct DailyForecast: Codable {
    let summary: String
    let icon: String
    let data: [DailyDataForecast]
    
    
}
