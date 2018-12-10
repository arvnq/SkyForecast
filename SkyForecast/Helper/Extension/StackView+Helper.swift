//
//  StackView+Helper.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/8/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    func configureLayoutMargin() {
        self.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.isLayoutMarginsRelativeArrangement = true
    }
}
