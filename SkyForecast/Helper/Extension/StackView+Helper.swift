//
//  StackView+Helper.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/8/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import UIKit

//encapsulating main view layout margins
extension UIStackView {
    func changeMainViewLayoutMargin() {
        self.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.isLayoutMarginsRelativeArrangement = true
    }
    
    //not using at the moment. save for future version
    func changeBottomViewLayoutMargin() {
        self.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 20)
        self.isLayoutMarginsRelativeArrangement = true
    }
}
