//
//  NSAttributedString+Helper.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/8/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import UIKit


extension NSAttributedString {
    /**
     Setting up attributed text for labels
     - Parameters:
         - field: the field name concern
         - value: value of the field
     - Returns: Method returns an NSAttributedString
     */
    static func setupText(forField field: String, usingValue value: String) -> NSAttributedString {

//        no use for these attributes at the moment
//        saving for future versions
//        let regularFontAttribute: [ NSAttributedString.Key: Any] = [
//            .font: UIFont.systemFont(ofSize: 14.0)
//        ]
//
//        let boldFontAttribute: [ NSAttributedString.Key: Any ] = [
//            .font: UIFont.boldSystemFont(ofSize: 14.0)
//        ]
        
        /// an attribute containing .foregroundColor
        let fgColorAttribute: [ NSAttributedString.Key: Any ] = [
            .foregroundColor: UIColor.gray,
        ]
        
        /// create a mutableAttributed string first then append the value applying the fgColorAttribute
        let attributedFieldValue = NSMutableAttributedString(string: field, attributes: fgColorAttribute)
        attributedFieldValue.append(NSAttributedString(string: value, attributes: [:]))
        
        return attributedFieldValue
    }
}
