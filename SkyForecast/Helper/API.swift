//
//  API.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/21/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

struct Api {
    static var key: String!
    static var baseURL: URL = URL(string: PropertyKeys.baseURL)!
    
    static var queryDictionary: [String: String] = [
        "exclude":"minutely,hourly,alerts,flags",
        "units":"ca"
    ]
}
