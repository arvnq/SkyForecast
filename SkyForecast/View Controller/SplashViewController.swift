//
//  SplashViewController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/26/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

//For future version
class SplashViewController: UIViewController {

    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(activityIndicator)
        
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.5)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            self.activityIndicator.stopAnimating()
        }
        
        showViewController()
        
    }
    
    func showViewController() {
        
        guard let forecast = AppDelegate.shared.forecast else {
            AppDelegate.shared.rootViewController.showLocationListView()
            return
        }
        
        if forecast.isFavourite {
            AppDelegate.shared.rootViewController.showForecastView()
        } else {
            AppDelegate.shared.rootViewController.showLocationListView()
        }
        
    }

}
