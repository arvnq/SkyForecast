//
//  ViewController.swift
//  SkyForecast
//
//  Created by Arvin Quiliza on 11/19/18.
//  Copyright © 2018 arvnq. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var locations: LocationList
    
    //required if we're going to define a non-optional var, in this case, locations
    required init?(coder aDecoder: NSCoder) {
        locations = LocationList()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = PropertyKeys.locationSelectionTitle
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }


}

extension LocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.chosenLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.locationCellIdentifier, for: indexPath)
        cell.textLabel?.text = locations.chosenLocations[indexPath.row].locationName
        
        
        return cell
    }
    
    
}

