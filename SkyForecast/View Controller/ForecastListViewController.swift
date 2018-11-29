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
        
        if let faveForecast = faveForecast {
            destinationVC.forecast = faveForecast == forecast ? faveForecast : forecast
        } else {
            destinationVC.forecast = forecast
        }
        
        //destinationVC.delegate = self
        
    }
    
    //use later
    @IBAction func unwindToForecast(_ segue: UIStoryboardSegue) {
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
        
        cell.textLabel?.text = FrequencyForecast.forecastTitle(forFrequency: frequency)
        return cell
    }
    
    
}

//extension ForecastListViewController: ForecastViewControllerDelegate {
//    func forecastViewController(_ forecastViewController: ForecastViewController, didUnwindToLocation forecast: Forecast?) {
//        //do nothing
//    }
//
//    func forecastViewController(_ forecastViewController: ForecastViewController, didUnwindToForecast forecast: Forecast?) {
//        guard let forecast = forecast else {  return }
//
//        navigationController?.popViewController(animated: true)
//        //ForecastController.shared.saveForecast(forecast)
//        print("ForecastListView!!!")
//
//    }
//
//
//}

