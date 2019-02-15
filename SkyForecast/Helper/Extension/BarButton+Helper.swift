//
//  BarButton+Helper.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/5/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    /**
     Manages bar buttons by assigning image and constant value on height and width constraint.
     - Parameters:
         - target: target whose action method is called
         - action: Selector identifying the action method to be called
         - imageName: the image to be used
     - Returns: UIBarButtonItem instantiated with the custom button set
     */
    static func menuButton(_ target: Any?, action: Selector, using imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = .black
        
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            (barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 25.0))!,
            (barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 25.0))!
            ])
        
        return barButtonItem
    }
}
