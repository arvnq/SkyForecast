//
//  WeeklyForecastTableViewCell.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/4/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit
import WebKit

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

    func configureCell(using forecast: DailyDataForecast) {
        
        dailyForecast = forecast
        
        forecastDate.text = Double(forecast.time).convertEpochTime()
        summary.text = forecast.summary
        highTemperature.text = String(forecast.temperatureHigh)
        lowTemperature.text = String(forecast.temperatureLow)
        windBearing.text = String(forecast.windBearing)
        windSpeed.text = String(forecast.windSpeed)
        
        loadIcon()
    }
    
    func loadIcon() {
        do {
            guard let filePath = Bundle.main.path(forResource: "skycons", ofType: "html") else { return }
            let contents = try String(contentsOfFile: filePath)
            let baseUrl = URL(fileURLWithPath: filePath)
            
            forecastIcon.loadHTMLString(contents, baseURL: baseUrl)
        } catch {
            print("Error loading Icon")
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let dailyForecast = dailyForecast else { return }
        
        let icon = dailyForecast.icon
        let iconToDisplay = icon.replacingOccurrences(of: "-", with: "_").uppercased()
        
        let jsIconLoader = "var skycons = new Skycons({'color':'red'});" +
            "skycons.set('skycon', Skycons.\(iconToDisplay) );" +
        "skycons.play();"
        
        webView.evaluateJavaScript(jsIconLoader, completionHandler: nil)
    }
}
