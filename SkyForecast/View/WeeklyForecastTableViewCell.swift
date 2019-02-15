//
//  WeeklyForecastTableViewCell.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/4/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit
import WebKit

/**
 TableView cell representing the rows of each forecast weekly
 */
class WeeklyForecastTableViewCell: UITableViewCell, WKNavigationDelegate{

    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var highTemperature: UILabel!
    @IBOutlet weak var lowTemperature: UILabel!
    @IBOutlet weak var windBearing: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    @IBOutlet weak var forecastIcon: WKWebView!
    
    var dailyForecast: DailyDataForecast?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        forecastIcon.navigationDelegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /**
     Configure each of the cell/row in the weekly forecast.
     - Parameter forecast: It uses the dailyDataForecast containing the hourly / daily data
     */
    func configureCell(using forecast: DailyDataForecast) {
        
        dailyForecast = forecast
        
        forecastIcon.loadIcon()
        forecastDate.text = Double(forecast.time).convertEpochTime()
        summary.text = forecast.summary
        
        highTemperature.attributedText = NSAttributedString.setupText(forField: "High: ", usingValue: String(forecast.temperatureHigh).degree(temperature: "C"))
        lowTemperature.attributedText = NSAttributedString.setupText(forField: "Low: ", usingValue: String(forecast.temperatureLow).degree(temperature: "C"))
        windBearing.attributedText = NSAttributedString.setupText(forField: "Wind Direction: ", usingValue: String(forecast.windBearing).degree())
        windSpeed.attributedText = NSAttributedString.setupText(forField: "Wind Speed: ", usingValue: String(forecast.windSpeed).kmPHr()) 
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let dailyForecast = dailyForecast else { return }
        
        let icon = dailyForecast.icon
        let iconToDisplay = icon.replacingOccurrences(of: "-", with: "_").uppercased()
        
        let jsIconLoader = "var skycons = new Skycons({'color':'gray'});" +
            "skycons.set('skycon', Skycons.\(iconToDisplay) );" +
            "skycons.play();"
        
        webView.evaluateJavaScript(jsIconLoader, completionHandler: nil)
    }
}
