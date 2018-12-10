//
//  AlertView.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/5/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import UIKit

//alert will display when fetching forecast failed
struct AlertView {
    
    static func showBasicAlert(on controller: UIViewController, withMessage message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Okay", style: .cancel) { (alert) in
            executeAlert(onController: controller)
        }
        
        alertController.addAction(alertAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    static func showApiErrorAlert(on controller: ForecastViewController) {
        showBasicAlert(on: controller, withMessage: "Cannot retrieve forecast. Please try again later.")
    }
    
    static func executeAlert(onController controller: UIViewController) {
        controller.performSegue(withIdentifier: "unwindToLocation", sender: nil)
    }
}
