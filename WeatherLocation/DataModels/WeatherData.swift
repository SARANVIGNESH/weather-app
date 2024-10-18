//
//  WeatherData.swift
//  WeatherLocation
//
//  Created by CSS on 13/07/22.
//

import Foundation
// creating struct for weather data
struct Weather: Codable {
    var coord: CodeData
    var weather: [WeatherData]
    var base: String
    var main: MainData
    var visibility: Int
    var wind: WindData
    var clouds: CloudsData
    var dt: Int
    var sys: SysData
    var timezone: Int
    var name: String
    var cod: Int
    
}

struct CodeData: Codable {
    var lon: Double
    var lat: Double
}
struct WeatherData: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
}
struct MainData: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
    
    
}
struct WindData: Codable {
    var speed: Double
    var deg: Int
}
struct CloudsData: Codable {
    var all: Int
}
struct SysData: Codable {
    var id: Int
    var type: Int
    var country: String
    var sunrise: Int
    var sunset: Int
}
 

