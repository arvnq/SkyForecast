//
//  String+Helper.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/8/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

//making string type append degree and km/hr
extension String {
    
    /// suffixes the degree symbol on string self
    func degree(temperature: String = "") -> String {
        return "\(self)\u{00B0}\(temperature)"
    }
    
    /// suffixes the km/h unit on string self
    func kmPHr() -> String {
        return "\(self)km/h"
    }
    
}
