//
//  ForecastViewController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/20/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherForecast.Frequency.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.forecastCellIdentifier, for: indexPath)
        let frequency = WeatherForecast.Frequency.allCases[indexPath.row]
        
        cell.textLabel?.text = WeatherForecast.forecastTitle(forFrequency: frequency)
        return cell
    }
    
    
}
