//
//  Double+Helper.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/5/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

extension Double {
    /**
     converts epoch time to readable format
     - Returns: the string representation of the epoch time
    */
    func convertEpochTime() -> String{
        let readableDate = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "EEEE, MMM d"
        
        let timeZone = TimeZone.autoupdatingCurrent.identifier as String
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        
        return dateFormatter.string(from: readableDate)
    }
}
