//
//  URL+Helper.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/21/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

//URL extension for setting up query parameters
extension URL {
    func withQuery(on queryParam: [String: String]) -> URL? {
        
        var component = URLComponents(url: self, resolvingAgainstBaseURL: true)
        component?.queryItems = queryParam.compactMap {
            return URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return component?.url
    }
}
