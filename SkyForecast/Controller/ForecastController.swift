//
//  ForecastController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/21/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import UIKit

/**
 Handles the fetching of forecast from the webservice and the saving of forecast into Document Directory.
 This controller should have only one instance throughout the app hence singleton.
 */
class ForecastController {
    
    static let shared = ForecastController()
    let key: String
    let baseURL: URL
    
    var faveForecast: Forecast?
    
    private init() {
        self.key = Api.key
        self.baseURL = Api.baseURL
        
    }
    
    /**
     Main method of fetching forecast from web server. It returns a complete forecast from the decoded data.
     - Parameters:
         - location: contains the latitude and longitude of the place you want to fetch the forecast of.
         - completion: an escaping closure that returns the complete forecast
     */
    func fetchForecast(forLocation location: Location, completion: @escaping (CompleteForecast?)->Void) {
        
        /// get the initial url from the base, key and locations coordinates
        let initialUrl = baseURL.appendingPathComponent(key).appendingPathComponent("\(location.locationLatitude),\(location.locationLongitude)")
        
        /// apply the query extension to stitch the query dictionary into a final url
        guard let finalUrl = initialUrl.withQuery(on: Api.queryDictionary) else { return }
        
        /// dataTask object main responsible for the fetching and decoding the json data and returning a complete forecast.
        let dataTask = URLSession.shared.dataTask(with: finalUrl) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data {
                let forecastResponse = try? jsonDecoder.decode(CompleteForecast.self, from: data)
                completion(forecastResponse)
            } else {
                completion(nil)
            }
        }
        dataTask.resume()
    }
    
    // saving the forecast.json in archive.
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // FIXME: Major issue. I should be saving the json search instead of the forecast object
    let archiveUrl = documentDirectory.appendingPathComponent("forecast").appendingPathExtension("json")
    
    
    /// Loading the foreacast
    /// - Returns: Forecast object
    func loadForecast() -> Forecast? {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: archiveUrl)
            let forecast = try jsonDecoder.decode(Forecast.self, from: data)
            return forecast
        } catch {
            //fatalError()
            return nil
        }
    }
    
    /// Saving the forecast
    /// - Parameter forecast: forecast to be saved
    func saveForecast(_ forecast: Forecast?) {
        let jsonEncoder = JSONEncoder()
        
        do {
            let forecastData = try jsonEncoder.encode(forecast)
            try forecastData.write(to: archiveUrl)
            
        } catch {
            fatalError()
        }
    }
   
}
