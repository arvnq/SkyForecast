//
//  ViewController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/19/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

class LocationListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var locations: LocationList
    
    //required if we're going to define a non-optional var, in this case, locations
    required init?(coder aDecoder: NSCoder) {
        locations = LocationList()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = PropertyKeys.locationSelectionTitle
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.segueSelectForecast {
            guard let destinationVC = segue.destination as? ForecastListViewController,
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell)  else { return }
            
            tableView.deselectRow(at: indexPath, animated: true)
            destinationVC.location = locations.chosenLocations[indexPath.row]
            
        }
    }
    
    @IBAction func unwindToLocation(_ segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! ForecastViewController
        
        guard let forecast = sourceVC.forecast else { return }
        
        
        navigationController?.popViewController(animated: true)
        
            ForecastController.shared.saveForecast(forecast)
       
    }

}

extension LocationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.chosenLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.locationCellIdentifier, for: indexPath)
        cell.textLabel?.text = locations.chosenLocations[indexPath.row].locationName
        
        
        return cell
    }
    
    
}

//
//extension LocationListViewController: ForecastViewControllerDelegate {
//    func forecastViewController(_ forecastViewController: ForecastViewController, didUnwindToLocation forecast: Forecast?) {
//
//        guard let forecast = forecast else {
//            return
//        }
//        
//        navigationController?.popViewController(animated: true)
//        if forecast.isFavourite {
//            ForecastController.shared.saveForecast(forecast)
//        } else {
//            ForecastController.shared.saveForecast(nil)
//        }
//    }
//    
//    func forecastViewController(_ forecastViewController: ForecastViewController, didUnwindToForecast forecast: Forecast?) {
//        //do nothing
//    }
//    
//    
//}

