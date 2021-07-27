//
//  CurrentSummary.swift
//  weather
//
//  Created by Britty Bidari on 27/07/2021.
//

import Foundation

class CurrentSummary {
  private let currentSummary: CurrentWeatherSummary
  
  var sunriseTimeFmt: String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: currentSummary.sunriseTime)
  }
  
  var sunsetTimeFmt: String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: currentSummary.sunsetTime)
  }
  
  var windSpeed: String {
    let kmh = currentSummary.windSpeed
    let mph = kmh / 1.609
    return String(format: "%.0f mi/h", mph)
  }
  
  var windDirection: String {
    currentSummary.windDirection
  }
  
  var uvIndex: String {
    String(format: "%.0f", currentSummary.uvIndex)
  }
  
  var humidity: String {
    "\(currentSummary.humidity)%"
  }
  
  init(weatherSummary: CurrentWeatherSummary) {
    self.currentSummary = weatherSummary
  }
}
