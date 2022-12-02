//
//  Sys.swift
//  WeatherMap
//
//  Created by Nurym Siyrbayev on 02.12.2022.
//

import Foundation

struct Sys: Decodable {
    let country: String?
    let sunriseUnixDateTime: Int?
    let sunsetUnixDateTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case country
        case sunriseUnixDateTime = "sunrise"
        case sunsetUnixDateTime = "sunset"
    }
}
