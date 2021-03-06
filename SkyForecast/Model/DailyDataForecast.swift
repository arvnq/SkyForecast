//
//  DailyDataForecast.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/22/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

/**
 Daily forecast represents the hourly (which is the first daily) and the whole week forecast.
 CodingKey is included because there is a need for consistency in the naming convention.
 */
struct DailyDataForecast: Codable, DataForecast {
    let time: Int32
    let summary: String
    let icon: String
    let temperatureHigh: Double
    let temperatureLow: Double
    let windBearing: Double
    let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case temperatureHigh
        case temperatureLow
        case windBearing
        case windSpeed
    }
    
    // init(from:) is needed if we are to decode complex types. if we are going to decode primitive types only,
    // we can omit it and let compiler create it for us
//    init(from decoder: Decoder) throws {
//        do {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            self.time = try container.decode(Int32.self, forKey: .time)
//            self.summary  = try container.decode(String.self, forKey: .summary)
//            self.icon  = try container.decode(String.self, forKey: .icon)
//            self.temperatureHigh  = try container.decode(Double.self, forKey: .temperatureHigh)
//            self.temperatureLow  = try container.decode(Double.self, forKey: .temperatureLow)
//            self.windBearing  = try container.decode(Double.self, forKey: .windBearing)
//            self.windSpeed  = try container.decode(Double.self, forKey: .windSpeed)
//
//        } catch {
//            fatalError()
//        }
//    }
}
