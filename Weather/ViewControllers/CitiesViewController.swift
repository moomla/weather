//
//  CitiesViewController.swift
//  Weather
//
//  Created by dv51343 on 17/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {

    var cities: [City?]?
    var selectedCity: City?
    var dataProvider: WeatherService? //injected data provider
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        cities = dataProvider?.citiesList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if type(of: segue.destination) == WeatherDataViewController.self {
            let weatherVC = segue.destination as! WeatherDataViewController
            weatherVC.dataProvider = dataProvider
            if let city = selectedCity {
                weatherVC.city = city
            }
        }
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if let city = cities?[indexPath.row] {
            cell.textLabel?.text = city.city
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let city = cities?[indexPath.row] {
            selectedCity = city
            self.performSegue(withIdentifier: "showWeather", sender: nil)
        }
    }
}
