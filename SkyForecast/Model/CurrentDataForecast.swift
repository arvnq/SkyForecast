//
//  WeatherForecast.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/21/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

struct CurrentDataForecast: Codable, DataForecast {
    let time: Int32
    let summary: String
    let icon: String
    let temperature: Double
    let windBearing: Double
    let windSpeed: Double
    
    //if there are different naming in the data returned, assign it to the cases below.
    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case temperature
        case windBearing
        case windSpeed
    }
    
    // init(from:) is needed if we are to decode complex types. like if there is something missing,
    // we are going to use an alternative for missing keys. Else we are good without one
//    init(from decoder: Decoder) throws {
//
//        do {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            self.time = try container.decode(Int32.self, forKey: .time)
//            self.summary = try container.decode(String.self, forKey: .summary)
//            self.icon = try container.decode(String.self, forKey: .icon)
//            self.temperature = try container.decode(Double.self, forKey: .temperature)
//            self.windBearing = try container.decode(Double.self, forKey: .windBearing)
//            self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
//
//        } catch {
//            fatalError("\(error)")
//        }
//    }
    
    
}
