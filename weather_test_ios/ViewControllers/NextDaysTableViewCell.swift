//
//  NextDaysTableViewCell.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-07.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit

class NextDaysTableViewCell: UITableViewCell {

    static let reuseId = "NextDays"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
}
