//
//  ListOfferModel.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-10.
//  Copyright © 2020 Alina. All rights reserved.
//

import Foundation

struct ListOfferModel: Codable {
    var main: MainOfferModel?
    var weather: [WeatherOfferModel]?
    var wind: WindOfferModel?
    var date: String?
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case wind
        case date = "dt_txt"
    }
}
