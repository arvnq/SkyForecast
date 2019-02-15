//
//  ForecastViewController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/20/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

class ForecastListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var location: Location?
    var forecast: Forecast?
    var faveForecast: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = PropertyKeys.forecastSelectionTitle
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ForecastViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            let location = location else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let forecastFrequency = FrequencyForecast.allCases[indexPath.row]
        self.forecast = Forecast(location: location, forecastFrequency: forecastFrequency, completeForecast: nil, isFavourite: false)
        self.faveForecast = ForecastController.shared.faveForecast
        
        /// If there is a faveForecast, then we need to check if the faveForecast is equal to the current forecast.
        /// if it is, then we simple assign it to destination's forecast, else we pass the new instantiated forecast.
        /// this is so because we need to check the isFavourite if it is saved as a favourite or not.
        if let faveForecast = faveForecast {
            destinationVC.forecast = faveForecast == forecast ? faveForecast : forecast
        } else {
            destinationVC.forecast = forecast
        }
        
    }
    
    //for future version
    @IBAction func unwindToForecast(_ segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! ForecastViewController
        self.location = sourceVC.forecast?.location
        print("ForecastListView!!!")
    }
    
}



extension ForecastListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FrequencyForecast.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.forecastCellIdentifier, for: indexPath)
        let frequency = FrequencyForecast.allCases[indexPath.row]
        
        /// assign the forecast title based on the frequency of the forecast in each row
        cell.textLabel?.text = FrequencyForecast.forecastTitle(forFrequency: frequency)
        return cell
    }
    
    
}

