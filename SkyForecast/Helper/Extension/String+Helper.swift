//
//  String+Helper.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/8/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

extension String {
    
    func degree(temperature: String = "") -> String {
        return "\(self)\u{00B0}\(temperature)"
    }
    
    func kmPHr() -> String {
        return "\(self)km/h"
    }
    
}
