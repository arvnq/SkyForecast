//
//  ForecastViewController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/22/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

protocol ForecastViewControllerDelegate: class {
    func forecastViewController(_ forecastViewController: ForecastViewController, didUnwindToLocation forecast: Forecast? )
    func forecastViewController(_ forecastViewController: ForecastViewController, didUnwindToForecast forecast: Forecast? )
}

class ForecastViewController: UIViewController {

    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var windBearing: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    var forecast: Forecast?
    weak var delegate: ForecastViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        guard let completeForecast = forecast?.completeForecast,
            let forecastFrequency = forecast?.forecastFrequency else { return }
        
        navigationItem.title = FrequencyForecast.forecastTitle(forFrequency: forecastFrequency)
        locationName.text = completeForecast.timezone
        currentTemperature.text = String(completeForecast.currently.temperature)
        summary.text = completeForecast.currently.summary
        windBearing.text = String(completeForecast.currently.windBearing)
        windSpeed.text = String(completeForecast.currently.windSpeed)
        
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
       self.forecast?.toggleFavourite()
        
        print("test")
    }
    
    @IBAction func unwindToLocation(_ sender: Any) {
        performSegue(withIdentifier: "unwindToLocation", sender: nil)
    }
    
    @IBAction func unwindToForecast(_ sender: Any) {
        delegate?.forecastViewController(self, didUnwindToForecast: forecast)
    }
    
}
