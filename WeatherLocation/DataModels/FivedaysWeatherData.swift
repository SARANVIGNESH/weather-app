//
//  FivedaysWeatherData.swift
//  WeatherLocation
//
//  Created by CSS on 16/07/22.
//

import Foundation
// creating struct for next 5 days weather data
struct FiveDays: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [WeatherInfo]
//    let clouds: Clouds
//    let wind: Wind
//    let visibility: Int
//    let pop: Double
//    let rain: Rain
//    let sys: Sys
    let dt_txt: String
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feels_like, temp_min, temp_max: Double
    let pressure, sea_level, grnd_level, humidity: Int
    let temp_kf: Double
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: Codable {
    case d
    case n
}

// MARK: - Weather
struct WeatherInfo: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

//enum Icon: Codable {
//    case the10D
//    case the10N
//}

//enum MainEnum: Codable {
//    case rain
//}

//enum Description: Codable {
//    case lightRain
//    case moderateRain
//}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
