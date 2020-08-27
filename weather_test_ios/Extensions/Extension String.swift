//
//  Extension.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-22.
//  Copyright © 2020 Alina. All rights reserved.
//
import Foundation

extension String {
   
    public func getDateComponents() -> DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self) ?? Date()
        let calendar = Calendar.current
        
        return calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    }
}
