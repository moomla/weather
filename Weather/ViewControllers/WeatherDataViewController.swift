//
//  WeatherDataViewController.swift
//  Weather
//
//  Created by dv51343 on 24/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class WeatherDataViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var tempRangeLabel: UILabel!
    @IBOutlet weak var celsiusButton: UIButton!
    @IBOutlet weak var fahrenheitButton: UIButton!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var city: City? { //injected city
        didSet {
            loadData()
        }
    }

    var dataProvider: WeatherService? { //injected data provider
        didSet {
            loadData()
        }
    }
    var weatherData: WeatherData? //loaded data
    var metricSystem: DegreesMetricSystem = .celsius {
        didSet {
            weatherData?.metricSystem = metricSystem
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Current weather"
        view.accessibilityIdentifier = "weatherDetailsScreen"
        self.celsiusButton.setTitle("C", for: .normal)
        self.fahrenheitButton.setTitle("F", for: .normal)
        let buttonTextColor = UIColor(red: 0, green: 0x86, blue: 0xB3)
        self.celsiusButton.setTitleColor(buttonTextColor, for: .normal)
        self.fahrenheitButton.setTitleColor(buttonTextColor, for: .normal)
        self.celsiusButton.layer.borderColor = buttonTextColor.cgColor
        self.fahrenheitButton.layer.borderColor = buttonTextColor.cgColor
        self.celsiusButton.layer.borderWidth = 1
        self.fahrenheitButton.layer.borderWidth = 1
        
        self.noDataView.isHidden = false
        self.noDataView.accessibilityIdentifier = "noDataView"
        self.errorLabel.accessibilityIdentifier = "errorLabel"
        self.activityIndicator.accessibilityIdentifier = "activityIndicator"
        self.titleLabel.accessibilityIdentifier = "cityNameLabel"
        self.currentTempLabel.accessibilityIdentifier = "currentTempLabel"
        self.descriptionLabel.accessibilityIdentifier = "descriptionLabel"
        self.celsiusButton.accessibilityIdentifier = "celsiusButton"
        self.fahrenheitButton.accessibilityIdentifier = "fahrenheitButton"
        self.iconView.accessibilityIdentifier = "iconView"
        self.tempRangeLabel.accessibilityIdentifier = "tempRangeLabel"
        
        if self.weatherData != nil {
            updateView()
        }
    }
    
    
    func loadData() {
        guard let cityToLoad = city else { return }
        showLoading(true)
        dataProvider?.loadWeather(in: cityToLoad, metricSystem: metricSystem) { [weak self] (weather: WeatherData?, error: Error?) in
            guard let `self` = self else { return }
            
            self.showLoading(false)
            guard let loadedWeather = weather else{
                self.showErrorMessage("oops, some error occured")
                return
            }
            self.noDataView.isHidden = true
            self.weatherData = loadedWeather
            self.weatherData?.metricSystem = self.metricSystem
            self.updateView()
        }
    }
    
    func updateView() {
        guard let weather = weatherData else {
            return
        }
        
        self.titleLabel.text = weather.name
        self.descriptionLabel.text = weather.weatherDescription
        self.currentTempLabel.text = "Current temperature " + Utils.degreeFormated(weather.temp, metricSystem: metricSystem)
        self.tempRangeLabel.text = "Today " + Utils.degreeFormated(weather.temp_min, metricSystem: metricSystem)  + " - " + Utils.degreeFormated(weather.temp_max, metricSystem: metricSystem)
        
        if let icon = weatherData?.icon {
            dataProvider?.loadIcon(icon){ [weak self] (image, error) in
                guard let `self` = self else { return }
                self.iconView.image = image
            }
        }
        self.view.backgroundColor = Utils.colorByCode(weather.code)
    }
    
    @IBAction func celciusPressed(sender: UIButton) {
        metricSystem = .celsius
        updateView()
    }
    
    @IBAction func fahrenheitPressed(sender: UIButton) {
        metricSystem = .fahrenheit
        updateView()
    }
    
    
    func showLoading(_ showLoading: Bool) {
        if self.view == nil { return }
        self.noDataView.isHidden = !showLoading
        self.activityIndicator.isHidden = !showLoading
        if showLoading {
            self.activityIndicator.startAnimating()
        }else{
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showErrorMessage(_ message: String){
        self.noDataView.isHidden = false
        self.errorLabel.isHidden = false
        self.errorLabel.text = message
    }
    
}
