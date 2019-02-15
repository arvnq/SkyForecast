//
//  API.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/21/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

/**
 Api blue print. Api contains the api access key and a base url.
 It also contains the queryDictionary for the query items used in fetch.
 */
struct Api {
    static var key: String!
    static var baseURL: URL = URL(string: PropertyKeys.baseURL)!
    
    static var queryDictionary: [String: String] = [
        "exclude":"minutely,hourly,alerts,flags",
        "units":"ca"
    ]
}
