//
//  CurrentWeatherViewModel.swift
//  Stormy
//
//  Created by Chris William Sehnert on 12/21/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel {
    let temperature: String
    let humidity: String
    let precipitationProbability: String
    let summary: String
    let icon: UIImage
    
    init(model: CurrentWeather) {
        let roundedTemperature = Int(model.temperature)
        self.temperature = "\(roundedTemperature)º"
        
        let humidityPercentValue = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentValue)%"
        
        let precipProbabilityPercentValue = Int(model.precipProbability * 100)
        self.precipitationProbability = "\(precipProbabilityPercentValue)%"
        
        self.summary = model.summary
        self.icon = model.iconImage
    }
    
    
}


