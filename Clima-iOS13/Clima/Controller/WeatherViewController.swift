//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    let repo: RemoteRepository = .init()
    let locationService = CLLocationManager()
    

    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        locationService.requestLocation()
    }
}

extension WeatherViewController {
    private func setup() {
        setupLocation()
        searchLabel.delegate = self
    }
    private func setupUI(temperature: Double, name: String, iconName: String){
        temperatureLabel.text = String(format: "%g", temperature)
        cityLabel.text = name
        conditionImageView.image = UIImage(systemName: iconName)
    }
    
    private func setupLocation(){
        locationService.requestWhenInUseAuthorization()
        locationService.delegate = self
        locationService.requestLocation()
    }
    
    private func requestWeatherInfo<T>(with data: T, using handler: (T, @escaping (Result<WeatherModel, APIError>) -> Void) -> Void){
        let completion: (Result<WeatherModel, APIError>) -> Void = { response in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                switch response {
                case .success(let data):
                    setupUI(temperature: data.temp, name: data.name, iconName: data.iconName)
                case .failure(let err):
                    self.cityLabel.text = err.localizedDescription
                }
            }
        }
        switch data{
        case is String:
            handler(data, completion)
            
        case is CLLocation:
            handler(data, completion)
        default:
            return
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text {
            requestWeatherInfo(with: cityName, using: repo.fetchData)
            textField
                .text = ""
        }
    }
}

extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locations = locations.last else{
            return
        }
        locationService.stopUpdatingLocation()
        requestWeatherInfo(with: locations, using: repo.fetchData)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
