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
    
    
    // let downloader = JSONDownloader()
    let decoder = JSONDecoder() // this type added along with Codable protocol
    
    let session: URLSession
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    typealias WeatherCompletionHandler = (Weather?, Error?)->Void
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, Error?)->Void
    
    private func getWeather (at location: LocationCoordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
        
        guard let url = URL(string: location.description, relativeTo: baseURL) else {
            completion(nil, DarkSkyError.invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, DarkSkyError.requestFailed)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(Weather.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, DarkSkyError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        /*
         // JSONDecoder takes care of this functionality...
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
        */
        task.resume()
    }
    
    func getCurrentWeather(at location: LocationCoordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        getWeather(at: location) { weather, error in
            completion(weather?.currently, error)
        }
    }
}



