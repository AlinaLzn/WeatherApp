//
//  MainTableViewController.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-07.
//  Copyright © 2020 Alina. All rights reserved.
//

import UIKit
import CoreLocation

class MainTableViewController: UITableViewController {
    
    // MARK: - Variable
    
    var loaderView = LoaderView()
    
    var offerModel: OfferModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let locationManager = CLLocationManager()
    
    private var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshContr), for: .valueChanged)
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(loaderView)
        playAnimation()
        tableView.addSubview(refresh)
                
        locationManager.delegate = self
        
        setUserLocation()
    }
    
    // MARK: - Return current day

    private func getCurrentDay() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return components.day ?? 0
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let modelForWeather = self.offerModel?.list?[safe: indexPath.row]
        let imageName = modelForWeather?.weather?.first?.getImage()
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayTableViewCell.reuseId, for: indexPath) as? TodayTableViewCell else { return UITableViewCell() }
            cell.cityLabel?.text = offerModel?.city?.name ?? "City Not Found"
            cell.weatherLabel?.text = modelForWeather?.weather![indexPath.row].main
            cell.temperatureLabel?.text = "\(Int(modelForWeather?.main?.temp ?? 0))°C"
            cell.weatherImage?.image = imageName
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NextDaysTableViewCell.reuseId, for: indexPath) as? NextDaysTableViewCell else { return UITableViewCell() }
            if let listInstance = offerModel?.list {
                for i in listInstance {
                    let selectedHour = 12
                    let currentDay = getCurrentDay()
                    let date = i.date?.getDateComponents()
                    let time = date?.hour
                    let day = date?.day
                    
                    if time == selectedHour && day! - currentDay - 1 == indexPath.row && date != nil {
                        
                        cell.dateLabel?.text = "\(date!.day ?? 0).\(date!.month ?? 0).\(date!.year ?? 0)"
                        cell.windLabel.text = "Wind \(i.wind?.speed ?? 0) m/s"
                        cell.pressureLabel.text = "Pressure \(i.main?.pressure ?? 0) mm Hg"
                        cell.weatherImage?.image = imageName
                        cell.temperatureLabel?.text = "\(Int(i.main?.temp ?? 0))°C"
                    }
                }
            }
            return cell
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 450
        default:
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK: - Location pressed
    
    @IBAction func locationPressed(_ sender: UIBarButtonItem) {
        playAnimation()
        setUserLocation(status: CLLocationManager.authorizationStatus())
    }
    
    // MARK: - Refresh Control
    
    @objc func refreshContr() {
        guard let city = offerModel?.city?.name else { return }
        setCity(city)
        refresh.endRefreshing()
    }
    
    // MARK: - Play animation
    
    private func playAnimation() {
        loaderView.show()
    }
    
    // MARK: - Stop animation

   private func stopAnimation() {
        loaderView.hide()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let currentDay = getCurrentDay()
        
        if case let vc as EnterCityViewController = segue.destination, segue.identifier == "enterCity" {
            vc.enterCityDelegate = self
            stopAnimation()
        }
        
        guard let cell = sender as? UITableViewCell else { return }
        let indexPath = tableView.indexPath(for: cell)
        if let listInstance = offerModel?.list {
        if case let vc as WeatherInHourViewController = segue.destination {
            if segue.identifier == "SegueForFirstCell" {
                
                    for weatherModel in listInstance {
                        let date = weatherModel.date?.getDateComponents()
                        if let day = date?.day {
                            if day == currentDay {
                                vc.modelsList.append(weatherModel)
                            }
                        }
                    }
                } else if segue.identifier == "SegueForNextCell" {
                    vc.offerModel = offerModel as OfferModel?
                    
                    for weatherModel in listInstance {
                        let day = weatherModel.date?.getDateComponents().day ?? 0
                        if day == currentDay + (indexPath?.row ?? 0) + 1 {
                            vc.modelsList.append(weatherModel)
                        }
                    }
                }
            }
        }
    }

    
     // MARK: - Get Ip
    
    func getIp() {
        NetworkManager.shared.getIpLocation() { json, error in
            if let name = json?["city"] {
                NetworkManager.shared.getWeather(city: name as? String) { [weak self] (model) in
                    guard model != nil else { return }
                    self?.offerModel = model
                    self?.updateData()
                }
            }
        }
    }
    
   func setUserLocation(status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
           getIp()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            print("error")
        }
    }
    
    private func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.stopAnimation()
        }
    }
}

extension MainTableViewController: EnterCityViewControllerDelegate {
    func setCity(_ city: String) {
        NetworkManager.shared.getWeather(city: city) { [weak self] (model) in
            if model != nil {
                self?.offerModel = model
                self?.updateData()
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension MainTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            NetworkManager.shared.getWeather(coordinate: (lon, lat)) { [weak self] model in
                guard model != nil else { return }
                self?.offerModel = model
                self?.updateData()
            }
        }
    }
    
    //MARK: - Only for first launching when status did change
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        setUserLocation(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

