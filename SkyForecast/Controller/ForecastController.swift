//
//  ForecastController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/21/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation

struct ForecastController {
    
    static let shared = ForecastController()
    let key: String
    let baseURL: URL
    
    private init() {
        self.key = Api.key
        self.baseURL = Api.baseURL
    }
    
    func fetchForecast(forLocation location: Location, completion: @escaping (CompleteForecast?)->Void) {
        
        let initialUrl = baseURL.appendingPathComponent(key).appendingPathComponent("\(location.locationLatitude),\(location.locationLongitude)")
        
        guard let finalUrl = initialUrl.withQuery(on: Api.queryDictionary) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: finalUrl) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data {
                let forecastResponse = try? jsonDecoder.decode(CompleteForecast.self, from: data)
                completion(forecastResponse)
            }
        }
        dataTask.resume()
    }
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let archiveUrl = documentDirectory.appendingPathComponent("forecast").appendingPathExtension("json")
    
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
