//
//  NetworkManager.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-10.
//  Copyright © 2020 Alina. All rights reserved.
//

import Foundation

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    func getWeather(city: String? = nil, coordinate: (long: String, lat: String)? = nil, result: @escaping ((OfferModel?) -> ())) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        if let city = city {
            urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: "e75888fba4f1f9d309c770e4c39525bb"),
            URLQueryItem(name: "units", value: "metric")]
        } else if let coordinate = coordinate {
            urlComponents.queryItems = [
                URLQueryItem(name: "appid", value: "e75888fba4f1f9d309c770e4c39525bb"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lat", value: coordinate.lat),
                URLQueryItem(name: "lon", value: coordinate.long)
            ]
        }
         
        let request = URLRequest(url: urlComponents.url!)
        
        let task = URLSession(configuration: .default)
        task.dataTask(with: request) {(data, response, error) in
            if let data = data {
                do {
                    let decoderOfferModel = try JSONDecoder().decode(OfferModel.self, from: data)
                    result(decoderOfferModel)
                } catch {
                    
                    print("Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func getIpLocation(completion: @escaping(NSDictionary?, Error?) -> Void) {
        guard let url = URL(string: "http://ip-api.com/json") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let content = data {
                    do {
                        if let object = try JSONSerialization.jsonObject(with: content, options: .allowFragments) as? NSDictionary {
                            completion(object, error)
                        }
                    }
                    catch {
                        completion(nil, nil)
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }).resume()
    }
}
