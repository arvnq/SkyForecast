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

    //MARK:- IBOUTLETS
    @IBOutlet weak var currentForecastStackView: UIStackView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var windBearing: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var forecastIcon: WKWebView!
    
    @IBOutlet weak var wholeDayForecastStackView: UIStackView!
    @IBOutlet weak var wdForecastDate: UILabel!
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
    
    
    //MARK:- PROPERTIES
    var forecast: Forecast?
    var alertLoader: UIAlertController = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    var skyIcon: String?
    
    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastIcon.navigationDelegate = self
        wdForecastIcon.navigationDelegate = self
        
        wkTableView.delegate = self
        wkTableView.dataSource = self
        
        // we need to make row height dynamic since we are not sure of the length of
        // the summary given by the api
        wkTableView.rowHeight = UITableView.automaticDimension
        wkTableView.estimatedRowHeight = 250.0
        
        //configuring correct image for left and right bar button. see Bar button extension
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(favouriteTapped), using: "unfavourite.pdf")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(unwindToForecast), using: "forecast.pdf")

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
    
    //MARK:- INSTANCE METHODS
    func updateUI() {
        guard let forecast = forecast,
            let completeForecast = forecast.completeForecast,
            let forecastFrequency = forecast.forecastFrequency else { return }
        
        navigationItem.title = FrequencyForecast.forecastTitle(forFrequency: forecastFrequency)
        locationName.text = forecast.location.locationName
        
        //switching what UI to display depending on the forecast frequence selected.
        switch(forecastFrequency) {
            case .currently: fillCurrentForecast(on: forecast.location, using: completeForecast.currently)
            case .hourly: fillWholeDayForecast(on: forecast.location, using: completeForecast.daily.data.first!)
            case .daily: fillWholeWeekForecast()
        }
        
        let image = forecast.isFavourite ? "favourite.pdf" : "unfavourite.pdf"
        (self.navigationItem.rightBarButtonItem?.customView as! UIButton).setImage(UIImage(named: image), for: .normal)
        //we used the custom view from the rhs barbutton because we can't get the custom view from faveButton outlet.
        //I believe this is because we are instantiating bar button item programmatically.
    }
    
    // show current weather forecast UI
    func fillCurrentForecast(on location: Location, using currentData: CurrentDataForecast) {
        currentForecastStackView.isHidden = false
        currentForecastStackView.changeMainViewLayoutMargin()
        
        skyIcon = currentData.icon
        forecastIcon.loadIcon()// loadForecastIcon(using: forecastIcon)
        
        currentTemperature.text = String(currentData.temperature).degree(temperature: "C")
        summary.text = "\(currentData.summary)" //and mostly breezy with a chance of meatballs
        
        windBearing.attributedText = NSAttributedString.setupText(forField: "Wind Direction: ", usingValue: String(currentData.windBearing).degree())
        windSpeed.attributedText = NSAttributedString.setupText(forField: "Wind Speed: ", usingValue: String(currentData.windSpeed).kmPHr())
    }
    
    // show 24-Hour forecast UI
    func fillWholeDayForecast(on location: Location, using wholeDayData: DailyDataForecast) {
        wholeDayForecastStackView.isHidden = false
        wholeDayForecastStackView.changeMainViewLayoutMargin()
        
        skyIcon = wholeDayData.icon
        wdForecastIcon.loadIcon() // loadForecastIcon(using: wdForecastIcon)
        
        wdForecastDate.text = Double(wholeDayData.time).convertEpochTime()
        wdSummary.text = wholeDayData.summary
        
        wdHighTemperature.attributedText = NSAttributedString.setupText(forField: "High: ", usingValue: String(wholeDayData.temperatureHigh).degree(temperature: "C"))
        wdLowTemperature.attributedText = NSAttributedString.setupText(forField: "Low: ", usingValue: String(wholeDayData.temperatureLow).degree(temperature: "C"))
        
        
        wdWindBearing.attributedText = NSAttributedString.setupText(forField: "Wind Direction: ", usingValue: String(wholeDayData.windBearing).degree())
        wdWindSpeed.attributedText = NSAttributedString.setupText(forField: "Wind Speed: ", usingValue: String(wholeDayData.windSpeed).kmPHr())
    }
    
    // reload table data to display forecast when 7-Day forecast is selected
    func fillWholeWeekForecast() {
        weeklyForecastStackView.isHidden = false
        weeklyForecastStackView.changeMainViewLayoutMargin()
        wkTableView.reloadData()
    }
    
    //MARK:- API
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
            } else { //if there is an issue in API call (network issue, etc.) show alert
                DispatchQueue.main.async { AlertView.showApiErrorAlert(on: self) }
                print("API Error. No forecast retrieved.")
                return
            }
        }
    }
    
    //MARK:- IBACTIONS
    //favourites button tapped. Save the forecast as favourite in Documents Directory
    @IBAction @objc func favouriteTapped(_ sender: UIButton) {
        self.forecast?.toggleFavourite()
        ForecastController.shared.faveForecast = forecast
        ForecastController.shared.saveForecast(forecast)
        
        let image = self.forecast?.isFavourite ?? false ? "favourite.pdf" : "unfavourite.pdf"
        
        //animating the star button
        UIView.animate(withDuration: 0.3, animations: {
            sender.setImage(UIImage(named: image), for: .normal)
            sender.transform = CGAffineTransform(rotationAngle: .pi)
            sender.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                sender.transform = CGAffineTransform.identity
            })
        }
        
        print("test")
    }
    
    @IBAction func unwindToLocation(_ sender: Any) {
        performSegue(withIdentifier: "unwindToLocation", sender: nil)
    }
    
    @IBAction @objc func unwindToForecast() {
        performSegue(withIdentifier: "unwindToForecast", sender: nil)
    }
    
}

//MARK:- EXTENSIONS
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
    
    //pass the current forecast icon from api and evaluate the script
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let skyIcon = skyIcon else { return }
        let iconToDisplay = skyIcon.replacingOccurrences(of: "-", with: "_").uppercased()
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
