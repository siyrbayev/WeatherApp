//
//  WeatherApi.swift
//  WeatherMap
//
//  Created by Nurym Siyrbayev on 02.12.2022.
//

import Foundation

protocol WeatherApiProtocol {
    func getHost(with cityName: String) -> String
    func getHost(lat:Double, lon: Double) -> String
}

struct WeatherApi {
    private let apiKey: String = "c959d6dd933572783812cf5789210e6a"
    let startHost: String = "https://api.openweathermap.org/data/2.5/weather?"
    let endHost: String = "&units=metric"
}

// MARK: WeatherApiProtocol

extension WeatherApi: WeatherApiProtocol {
    
    func getHost(with cityName: String) -> String {
        return startHost + "q=" + cityName + endHost + "&appid=" + apiKey
    }
    
    func getHost(lat: Double, lon: Double) -> String {
        return startHost + "lat="+String(lat )+"&lon="+String(lon )+endHost + "&appid=" + apiKey
    }
}
