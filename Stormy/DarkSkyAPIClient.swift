//
//  DarkSkyAPIClient.swift
//  Stormy
//
//  Created by Chris William Sehnert on 12/29/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

class DarkSkyAPIClient {
    fileprivate let secretKey = SecretKey()
    
    lazy var baseURL: URL = {
        return URL(string: "https://api.darksky.net/forecast/\(secretKey.darkSkyAPIKey)/")!
    }()
    
    let downloader = JSONDownloader()
    typealias WeatherCompletionHandler = (Weather?, DarkSkyError?)->Void
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, DarkSkyError?)->Void
    
    private func getWeather (at location: LocationCoordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
        
        guard let url = URL(string: location.description, relativeTo: baseURL) else {
            completion(nil, .invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                guard let weather = Weather(json: json) else {
                    completion(nil, .jsonParsingFailure)
                    return
                }
                completion(weather, nil)
            }
        }
        task.resume()
    }
    
    func getCurrentWeather(at location: LocationCoordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        getWeather(at: location) { weather, error in
            completion(weather?.currently, error)
        }
    }
}



