//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 5/8/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // https://darksky.net/dev/account
    fileprivate let darkSkyAPIKey = "469a2e386f9f712bbc0c2d8ce2ecac51"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseURL = URL(string: "https://api.darksky.net/forecast/\(darkSkyAPIKey)/")
        guard let forecastURL = URL(string: "37.8267,-122.4233", relativeTo: baseURL) else {
            return
        }
        
        /*
         //This represents the synchronous method for fetching a Data Object as JSON...
        let weatherData = try? Data(contentsOf: forecastURL!)
        print(weatherData ?? "NoData")""
        let json = try? JSONSerialization.jsonObject(with: weatherData!, options: [])
        print(json ?? "NoJSON")
        */
        
        // a URLRequest object creates an HTTP GET request by default....
        let request = URLRequest(url: forecastURL)
        // a URLSessionConfiguration object allows for multiple settings including authentication and cache...
        //... the Configuration is used to initialize the Session...this one uses default settings...
        let configuration = URLSessionConfiguration.default
        // a URLSession object allows for asynchronous Data fetching...
        let session = URLSession(configuration: configuration)
        // the Session.dataTask() method returns data directly to the app as a Data object...using closure parameters...
        // by contrast .downloadTask() retrieves contents of request and saves to temp file on disk...
        let dataTask = session.dataTask(with: request) { data, response, error in
            print(data ?? "Task failed")
        }
        
        // resume method calls session.dataTask()...
        dataTask.resume()

        let currentWeather = CurrentWeather(temperature: 90.0, humidity: 0.8, precipProbability: 0.2, summary: "Hot", icon: "clear-night")
        let viewModel = CurrentWeatherViewModel(model: currentWeather)
        displayWeather(using: viewModel)
    }
    
    func displayWeather(using viewModel: CurrentWeatherViewModel) {
        currentTemperatureLabel.text = viewModel.temperature
        currentHumidityLabel.text = viewModel.humidity
        currentPrecipitationLabel.text = viewModel.precipitationProbability
        currentWeatherIcon.image = viewModel.icon
        currentSummaryLabel.text = viewModel.summary
        
        
    }
}

