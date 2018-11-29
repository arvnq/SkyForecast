//
//  AppDelegate.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/19/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var forecast: Forecast?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do {
            if let url = Bundle.main.url(forResource: "darksky.apikey", withExtension: nil) {
                let key = try? String(contentsOf: url, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
                Api.key = key ?? ""
            }
            
        }
        
        //if forecast is not found, still return true
        guard let forecast = ForecastController.shared.loadForecast() else { return true }
        
        //no need to instantiate a window as we have a navigation controller already setup in storyboard
        //if we are going to implement this though, we need to assign a rootViewController because rootVC is nil
        //self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        //let initialNaviController: UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        let initialNaviController = self.window!.rootViewController as! UINavigationController

        if forecast.isFavourite {

            //add all VCs in the navigation stack, and make the forecastVC the last one to make it top of stack
            
            let forecastVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: PropertyKeys.sbIdForecastVC) as! ForecastViewController

            let locationVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: PropertyKeys.sbIdLocationListVC) as! LocationListViewController

            let forecastFrequencyVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: PropertyKeys.sbIdForecastListVC) as! ForecastListViewController
            
            (forecastVC as! ForecastViewController).forecast = forecast
            ForecastController.shared.faveForecast = forecast
            
            initialNaviController.setViewControllers([locationVC, forecastFrequencyVC, forecastVC], animated: true)
            //initialNaviController.pushViewController(forecastVC, animated: true)
            //self.window?.rootViewController = initialNaviController
        }
        
        //self.window?.rootViewController = RootViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var rootViewController: RootViewController {
        return window?.rootViewController as! RootViewController
    }
}
