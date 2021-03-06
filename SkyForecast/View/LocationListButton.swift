//
//  LocationListButton.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/6/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

/// Custom button for showing the location list at the bottom of the forecast page
class LocationListButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    /// setup the button's constraint, image and tint color
    private func setupButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 20.0),
            self.widthAnchor.constraint(equalToConstant: 40.0)
        ])
        self.setImage(UIImage(named: "location.pdf"), for: .normal)
        self.imageView?.tintColor = .black
    }
}

