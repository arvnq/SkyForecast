//
//  ForecastViewController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/22/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

//protocol ForecastViewControllerDelegate: class {
//    func forecastViewController(_ forecastViewController: ForecastViewController, didUnwindToLocation forecast: Forecast? )
//    func forecastViewController(_ forecastViewController: ForecastViewController, didUnwindToForecast forecast: Forecast? )
//}

class ForecastViewController: UIViewController {

    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var windBearing: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    var forecast: Forecast?
    
    //weak var delegate: ForecastViewControllerDelegate?
    
    var alertLoader: UIAlertController = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let forecast = forecast else { return }
        
        if forecast.isFavourite { // if favourite is true, we have a saved forecast
            updateUI()
        } else { // else we retrieve from api
            showAlertLoader()
            fetchForecast()
        }
    }
    
    func updateUI() {
        
        //updateBarButton()
        
        guard let completeForecast = forecast?.completeForecast,
            let forecastFrequency = forecast?.forecastFrequency else { return }
        
        navigationItem.title = FrequencyForecast.forecastTitle(forFrequency: forecastFrequency)
        locationName.text = completeForecast.timezone
        currentTemperature.text = String(completeForecast.currently.temperature)
        summary.text = completeForecast.currently.summary
        windBearing.text = String(completeForecast.currently.windBearing)
        windSpeed.text = String(completeForecast.currently.windSpeed)
        
    }
    
//    func updateBarButton() {
//        let selectForecastBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(unwindToForecast))
//
//        navigationItem.setLeftBarButton(selectForecastBarButton, animated: true)
//    }
    
    func fetchForecast() {
        guard let forecast = forecast else { return }
        
        ForecastController.shared.fetchForecast(forLocation: forecast.location) { (forecastResponse) in
            if let forecastResponse = forecastResponse { //inside the background thread
                    self.forecast?.completeForecast = forecastResponse
                
                // once api call has finished, dismiss the alert and updateUI in main thread
                // since we are still in the background. Execution happens after a second
                // since dismiss sometimes isn't called, hence need to delay dismissal
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismissAlertLoader()
                    self.updateUI()
                }
            }
        }
    }
    
    
    
    @IBAction func favouriteTapped(_ sender: Any) {
       self.forecast?.toggleFavourite()
        ForecastController.shared.saveForecast(forecast)
        print("test")
    }
    
    @IBAction func unwindToLocation(_ sender: Any) {
        //ForecastController.shared.saveForecast(forecast)
        performSegue(withIdentifier: "unwindToLocation", sender: nil)
        
       // AppDelegate.shared.rootViewController.showLocationListView()
    }
    
    @IBAction func unwindToForecast() {
        //ForecastController.shared.saveForecast(forecast)
        performSegue(withIdentifier: "unwindToForecast", sender: nil)
        //delegate?.forecastViewController(self, didUnwindToForecast: forecast)
        
       // AppDelegate.shared.rootViewController.showForecastListView()
    }
    
}

//extension for encapsulating the alertLoader
extension ForecastViewController {
    
    func showAlertLoader() {
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 23, width: 15, height: 15))
        
        activityIndicator.style = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        alertLoader.view.addSubview(activityIndicator)
        self.present(alertLoader, animated: true, completion: nil)

    }
    
    func dismissAlertLoader() {
        //alertLoader.view.removeFromSuperview()
        alertLoader.dismiss(animated: true, completion: nil)
    }
}
