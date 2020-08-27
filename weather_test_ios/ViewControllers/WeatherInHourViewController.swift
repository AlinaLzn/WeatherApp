//
//  WeatherInHourViewController.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-06.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit

class WeatherInHourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
  
    // MARK: - Variable
    
    var offerModel: OfferModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var modelsList = [ListOfferModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInHourTableViewCell.reuseId, for: indexPath) as? WeatherInHourTableViewCell else { return UITableViewCell() }
        
        let modelForWeather = self.modelsList[safe: indexPath.row]
        let imageName = modelForWeather?.weather?.first?.getImage()
        
        cell.dateLabel?.text = modelForWeather?.date
        cell.temperatureLabel?.text = "\(Int(modelForWeather?.main?.temp ?? 0))°C"
        cell.weatherImage?.image = imageName
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
