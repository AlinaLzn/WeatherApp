//
//  OfferModel.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-10.
//  Copyright © 2020 Alina. All rights reserved.
//

import Foundation

struct OfferModel: Codable {
    var list: [ListOfferModel]?
    var city: CityModel?
}
