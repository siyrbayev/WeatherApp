//
//  CityWeather.swift
//  WeatherMap
//
//  Created by Nurym Siyrbayev on 02.12.2022.
//

import Foundation

struct CityWeather: Decodable {
    let name: String?
    let weather: [Wether]?
    let temp: Temp?
    let sys: Sys?
    let currentUnixDateTime: Int?
    let timezoneSeconds: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case weather
        case temp = "main"
        case sys = "sys"
        case currentUnixDateTime = "dt"
        case timezoneSeconds = "timezone"
    }
}
