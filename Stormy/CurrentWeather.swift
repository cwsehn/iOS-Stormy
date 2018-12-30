//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Chris William Sehnert on 12/21/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit


struct CurrentWeather: Codable {
    let temperature: Double
    let humidity: Double
    let precipProbability: Double
    let summary: String
    let icon: String
    
    /*
    // the following enum is unneccessary...it is presented to demonstrate how Codable Protocol functions under the hood...
    // Codable will infer a CodingKey from the property name given it matches the key...ie: temperature == "temperature"
    enum CurrentWeatherCodingKeys: String, CodingKey {
        case temperature = "temperature"
        case humidity = "humidity"
        case precipProbability = "precipProbability"
        case summary = "summary"
        case icon = "icon"
    }
    */
}

extension CurrentWeather {
    var iconImage: UIImage {
        switch icon {
        case "clear-day": return #imageLiteral(resourceName: "clear-day")
        case "clear-night": return #imageLiteral(resourceName: "clear-night")
        case "rain": return #imageLiteral(resourceName: "rain")
        case "snow": return #imageLiteral(resourceName: "snow")
        case "sleet": return #imageLiteral(resourceName: "sleet")
        case "wind": return #imageLiteral(resourceName: "wind")
        case "fog": return #imageLiteral(resourceName: "fog")
        case "cloudy": return #imageLiteral(resourceName: "cloudy")
        case "partly-cloudy": return #imageLiteral(resourceName: "partly-cloudy-day")
        default: return #imageLiteral(resourceName: "default")
            
        }
    }
}


/*
 //The Following extension is not used with Codable protocol procedures....
extension CurrentWeather {
    struct Key {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let precipProbability = "precipProbability"
        static let summary = "summary"
        static let icon = "icon"
        
    }
    
    init? (json: [String:AnyObject]) {
        guard let tempValue = json[Key.temperature] as? Double,
        let humidityValue = json[Key.humidity] as? Double,
        let precipProbabilityValue = json[Key.precipProbability] as? Double,
        let summaryString = json[Key.summary] as? String,
            let iconString = json[Key.icon] as? String else {
                return nil
        }
        
        self.temperature = tempValue
        self.humidity = humidityValue
        self.precipProbability = precipProbabilityValue
        self.summary = summaryString
        self.icon = iconString
    }
 
 
}
*/

