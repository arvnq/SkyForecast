//
//  DataForecast.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/22/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

/**
 DataForecast contains all the necessary properties of a forecast
 */
protocol DataForecast {
    var time: Int32 { get }
    var summary: String { get }
    var icon: String { get }
    var windBearing: Double { get }
    var windSpeed: Double { get }
}
