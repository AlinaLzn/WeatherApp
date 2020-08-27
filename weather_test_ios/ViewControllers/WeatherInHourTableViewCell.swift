//
//  WeatherInHourTableViewCell.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-07.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit

class WeatherInHourTableViewCell: UITableViewCell {

    static let reuseId = "Cell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
}
