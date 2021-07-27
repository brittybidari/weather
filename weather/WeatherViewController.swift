//
//  WeatherViewController.swift
//  weather
//
//  Created by Britty Bidari on 26/07/2021.
//

import UIKit
import CoreLocation
import Combine


class WeatherViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var weatherConditionWords: UILabel!
    @IBOutlet weak var nameOfCityAndCountry: UILabel!
    @IBOutlet weak var temperatureInFahrenheit: UILabel!
    
    
    private var locationManager:CLLocationManager!
    private var weatherFetcher:WeatherFetcher!
    private var disposable = Set<AnyCancellable>()
    private var weatherSummary: WeatherSummary?
    
    var currentTempFmt: String {
        guard let temp = weatherSummary?.current.actualTemp.fahrenheight else { return "--º" }
        return String(format: "%.0fº", temp)
      }
      
      var feelsLikeTempFmt: String {
        guard let temp = weatherSummary?.current.feelsLikeTemp.fahrenheight else { return "--º" }
        return String(format: "%.0fº", temp)
      }
      
      var currentTempDescription: String {
        guard let description = weatherSummary?.current.weatherDetails.first?.weatherDescription else {
          return ""
        }
        return description.localizedCapitalized
      }
      
     
      
      var daySummaries: [DaySummary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Do any additional setup after loading the view.
        
       weatherFetcher = DataManager()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
        
        
        
    }
    
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
            fetchWeatherSummary(for: location.coordinate)
      
            print("latitude: \(latitude) \nlongitude: \(longitude)")
        }
       
    }
    
    func fetchWeatherSummary(for coordinate:CLLocationCoordinate2D ){
        weatherFetcher.weatherSummary(for: coordinate)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (value) in
                   switch value {
                   case .failure(let error):
                     self?.weatherSummary = nil
                     self?.daySummaries = []
                     print(error)
                   case .finished:
                     break
                   }
                 }) { [weak self] weatherSummary in
                   self?.weatherSummary = weatherSummary
                self?.daySummaries = weatherSummary.daily.map { DaySummary(daySummary: $0) }
                self?.updateViews()
               
               }.store(in: &disposable)
        
    }
    
    func updateViews(){
        currentWeatherIcon.image =  weatherSummary?.current.weatherDetails.first?.weatherIcon
        if let description = weatherSummary?.current.weatherDetails.first?.weatherDescription{
            weatherConditionWords.text = description.localizedCapitalized
        }
        nameOfCityAndCountry.text = weatherSummary?.timezone.capitalized
        
        if let temperature = weatherSummary?.current.actualTemp.fahrenheight{
            temperatureInFahrenheit.text = String(format:"%.0f°F",temperature)
        }
      
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user’s location
    }
    
    
    
}
