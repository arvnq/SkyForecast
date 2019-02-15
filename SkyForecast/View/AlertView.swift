//
//  AlertView.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/5/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import UIKit

/// Shows the alert when fetching forecast failed
struct AlertView {
    
    /**
     Basic alert showing the passed message and unwinding to Location VC
     - Parameters:
         - controller: where alert is presented
         - message: message inside the alert
     */
    static func showBasicAlert(on controller: UIViewController, withMessage message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Okay", style: .cancel) { (alert) in
            executeAlert(onController: controller)
        }
        
        alertController.addAction(alertAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    /**
     When there is an API error, this method is called.
     - Parameter controller: controller where the api call issue happened
     */
    static func showApiErrorAlert(on controller: ForecastViewController) {
        showBasicAlert(on: controller, withMessage: "Cannot retrieve forecast. Please try again later.")
    }
    
    /**
     Method that performs segue upon clicking Okay inside the alert
     - Parameter controller: controller that performs the segue
     */
    static func executeAlert(onController controller: UIViewController) {
        controller.performSegue(withIdentifier: "unwindToLocation", sender: nil)
    }
}
