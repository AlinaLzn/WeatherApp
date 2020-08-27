//
//  WeatherOfferModel.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-10.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit

struct WeatherOfferModel: Codable {
    var id: Int?
    var main: String?
  
    private func conditionName() -> String {
        guard let condition = id else { return "partlyCloudy"}
           switch condition {
           case 200...232:
            return "bolt"
           case 300...321:
               return "rain"
           case 500...531:
               return "storm"
           case 600...622:
               return "snow"
           case 701...781:
               return "fog"
           case 800:
               return "sun"
           case 801...804:
               return "partlyCloudy"
           default:
               return "partlyCloudy"
           }
       }
    
    public func getImage() -> UIImage? {
        return UIImage(named: conditionName())
    }
}

