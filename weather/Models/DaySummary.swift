//
//  DaySummary.swift
//  weather
//
//  Created by Britty Bidari on 27/07/2021.
//

import Foundation
import UIKit

class DaySummary: Identifiable {
  private let daySummary: DailyWeatherSummary
  
  var id = UUID()
  
  var day: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: daySummary.time)
  }
  
  var highTempFmt: String {
    String(format: "%.0fº", daySummary.maxTemp.fahrenheight)
  }
  
  var lowTempFmt: String {
    String(format: "%.0fº", daySummary.minTemp.fahrenheight)
  }
  
  var icon: UIImage? {
    daySummary.weatherDetails.first?.weatherIcon
  }
  
  init(daySummary: DailyWeatherSummary) {
    self.daySummary = daySummary
  }
}
