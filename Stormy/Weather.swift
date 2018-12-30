//
//  Weather.swift
//  Stormy
//
//  Created by Chris William Sehnert on 12/29/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let currently: CurrentWeather
}


/*
 // failable init?() not used with Codable protocol procedures...
extension Weather {
    init?(json: [String:AnyObject]) {
        guard let currentWeatherJson = json["currently"] as? [String:AnyObject], let currentWeather = CurrentWeather(json: currentWeatherJson) else {
            return nil
        }
        
        self.currently = currentWeather
    }
}
*/
