//
//  RootViewController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/26/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import UIKit


//For future version
class RootViewController: UIViewController {
    private var current: UIViewController
    
    init() {
        current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showInitViewController()
    }
    
    func showInitViewController() {
        addChild(current)
        
        current.view.frame = view.bounds
        view.addSubview(current.view)
        
        current.didMove(toParent: self)
    }
    
    func showLocationListView() {
        let new = UINavigationController(rootViewController: LocationListViewController())
        
        // when adding a new vc to custom container vc:
        // add vc as child of container vc
        // update vc's frame to container's bounds
        // add vc's view to container view
        // call didMove on vc
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        
        // when removing a current vc from custom container vc:
        // call willMove
        // remove vc's view from container view
        // call removeFromParent on vc
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
    }
    
    func showForecastListView() {
        let new = UINavigationController(rootViewController: ForecastListViewController())
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
    }
    
    func showForecastView() {
        let new = UINavigationController(rootViewController: ForecastViewController())
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
    }
}
