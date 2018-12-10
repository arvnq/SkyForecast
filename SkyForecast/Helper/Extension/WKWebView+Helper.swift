//
//  WKWebView+Helper.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 12/10/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    //load the html responsible for displaying icon canvas
    func loadIcon() {
        do {
            guard let filePath = Bundle.main.path(forResource: "skycons", ofType: "html") else { return }
            let contents = try String(contentsOfFile: filePath)
            let baseUrl = URL(fileURLWithPath: filePath)
            
            self.loadHTMLString(contents, baseURL: baseUrl)
            self.scrollView.isScrollEnabled = false;
        } catch {
            print("Error loading Icon")
        }
    }
}
