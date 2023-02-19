//
//  WeatherData.swift
//  Clima
//
//  Created by Richard Clifford on 19/02/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

// use decodable for json
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main : Decodable {
    let temp: Double
}

struct Weather : Decodable {
    let id: Int
    let description: String
}
