//
//  CustomTableViewCell.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-06.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit

class TodayTableViewCell: UITableViewCell {
    
    static let reuseId = "Today"
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
}
