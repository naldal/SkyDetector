//
//  ViewController.swift
//  SkyDetector
//
//  Created by 송하민 on 2021/05/15.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    
    @IBOutlet weak var ListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocation(latitude: 37.498206, longitude: 127.02761)
        WeatherDataSource.shared.fetch(location: location) {
            self.ListTableView.reloadData()
        }
    }


}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            
            if let weather = WeatherDataSource.shared.summary?.weather.first, let main = WeatherDataSource.shared.summary?.main {
                cell.weatherImageView.image = UIImage(named: weather.icon)
                cell.statusLabel.text = weather.description
                cell.minMaxLabel.text = "최고 \(main.temp_max.temperatureString) 최소 \(main.temp_min.temperatureString)"
                cell.currentTemperatureLable.text = "\(main.temp.temperatureString)"
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

