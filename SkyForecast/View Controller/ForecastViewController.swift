//
//  ForecastViewController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/22/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit
import WebKit

class ForecastViewController: UIViewController {

    
    @IBOutlet weak var currentForecastStackView: UIStackView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var windBearing: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var forecastIcon: WKWebView!
    
    @IBOutlet weak var wholeDayForecastStackView: UIStackView!
    @IBOutlet weak var wdSummary: UILabel!
    @IBOutlet weak var wdHighTemperature: UILabel!
    @IBOutlet weak var wdLowTemperature: UILabel!
    @IBOutlet weak var wdWindBearing: UILabel!
    @IBOutlet weak var wdWindSpeed: UILabel!
    @IBOutlet weak var wdForecastIcon: WKWebView!
    
    @IBOutlet weak var weeklyForecastStackView: UIStackView!
    @IBOutlet weak var wkTableView: UITableView!
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var faveButton: UIBarButtonItem!
    
    var forecast: Forecast?
    var alertLoader: UIAlertController = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastIcon.navigationDelegate = self
        wdForecastIcon.navigationDelegate = self
        
        wkTableView.delegate = self
        wkTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentForecastStackView.isHidden = true
        wholeDayForecastStackView.isHidden = true
        weeklyForecastStackView.isHidden = true
        
        guard let forecast = forecast else { return }
        
        if forecast.isFavourite { // if favourite is true, we have a saved forecast
            updateUI()
        } else { // else we retrieve from api
            showAlertLoader()
            fetchForecast()
        }
    }
    
    func updateUI() {
        guard let forecast = forecast,
            let completeForecast = forecast.completeForecast,
            let forecastFrequency = forecast.forecastFrequency else { return }
        
        navigationItem.title = FrequencyForecast.forecastTitle(forFrequency: forecastFrequency)
        locationName.text = forecast.location.locationName
        
        switch(forecastFrequency) {
            case .currently: fillCurrentForecast(on: forecast.location, using: completeForecast.currently)
            case .hourly: fillWholeDayForecast(on: forecast.location, using: completeForecast.daily.data.first!)
            case .daily: fillWholeWeekForecast()
        }
        
        faveButton.title = forecast.isFavourite ? "Unfavourite" : "Favourite"
        
    }
    
    func fillCurrentForecast(on location: Location, using currentData: CurrentDataForecast) {
        currentForecastStackView.isHidden = false
        currentTemperature.text = String(currentData.temperature)
        summary.text = currentData.summary
        windBearing.text = String(currentData.windBearing)
        windSpeed.text = String(currentData.windSpeed)
        loadForecastIcon(using: forecastIcon)
    }
    
    func fillWholeDayForecast(on location: Location, using wholeDayData: DailyDataForecast) {
        wholeDayForecastStackView.isHidden = false
        wdSummary.text = wholeDayData.summary
        wdHighTemperature.text = String(wholeDayData.temperatureHigh)
        wdLowTemperature.text = String(wholeDayData.temperatureLow)
        wdWindBearing.text = String(wholeDayData.windBearing)
        wdWindSpeed.text = String(wholeDayData.windSpeed)
        loadForecastIcon(using: wdForecastIcon)
    }
    
    func fillWholeWeekForecast() {
        weeklyForecastStackView.isHidden = false
        wkTableView.reloadData()
    }
    
    //invokes api call
    func fetchForecast() {
        guard let forecast = forecast else { return }
        
        ForecastController.shared.fetchForecast(forLocation: forecast.location) { (forecastResponse) in
            if let forecastResponse = forecastResponse { //inside the background thread
                    self.forecast?.completeForecast = forecastResponse
                
                // once api call has finished, dismiss the alert and updateUI in main thread bec we are still in the background.
                // Execution happens after a second since dismiss sometimes isn't called, hence need to delay dismissal
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismissAlertLoader()
                    self.updateUI()
                }
            }
        }
    }
    
    
    
    @IBAction func favouriteTapped(_ sender: Any) {
        self.forecast?.toggleFavourite()
        ForecastController.shared.faveForecast = forecast
        ForecastController.shared.saveForecast(forecast)
        print("test")
    }
    
    @IBAction func unwindToLocation(_ sender: Any) {
        performSegue(withIdentifier: "unwindToLocation", sender: nil)
    }
    
    @IBAction func unwindToForecast() {
        performSegue(withIdentifier: "unwindToForecast", sender: nil)
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

extension ForecastViewController: WKNavigationDelegate {
    //load the html responsible for displaying icon canvas
    func loadForecastIcon(using forecastIcon: WKWebView) {
        do {
            guard let filePath = Bundle.main.path(forResource: "skycons", ofType: "html") else { return }
            let contents = try String(contentsOfFile: filePath)
            let baseUrl = URL(fileURLWithPath: filePath)
            
            forecastIcon.loadHTMLString(contents, baseURL: baseUrl)
            
        } catch {
            print("HTML File Error")
        }
    }
    
    //evaluate script and pass the current forecast icon from api
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let icon = forecast?.completeForecast?.currently.icon else { return }
        let iconToDisplay = icon.replacingOccurrences(of: "-", with: "_").uppercased()
        
        let jsIconLoader = "var skycons = new Skycons({'color':'red'});" +
                            "skycons.set('skycon', Skycons.\(iconToDisplay) );" +
                            "skycons.play();"
        
        webView.evaluateJavaScript(jsIconLoader) { (any, error) in
            print("success!")
        }
    }
}

//table functions for 7-day weekly forecast
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast?.completeForecast?.daily.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekForecastCell", for: indexPath) as! WeeklyForecastTableViewCell
        
        if let dailyForecast = forecast?.completeForecast?.daily.data[indexPath.row] {
            cell.configureCell(using: dailyForecast)
        }
        
        return cell
    }
    
    
}
