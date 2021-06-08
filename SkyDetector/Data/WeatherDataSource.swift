//
//  WeatherDataSource.swift
//  SkyDetector
//
//  Created by 송하민 on 2021/06/03.
//

import Foundation
import CoreLocation

class WeatherDataSource {
    static let shared = WeatherDataSource()
    private init() {}
    
    var summary: CurrentWeather?
    var forecast: Forecast?
    
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent)
    
    let group = DispatchGroup()
    
    func fetch(location: CLLocation, completion: @escaping () -> ()) {
        group.enter()
        apiQueue.async {
            self.fetchCurrentWeather(location: location) { (result) in
                switch result{
                case .success(let data):
                    self.summary = data
                default:
                    self.summary = nil
                }
                self.group.leave()
            }
        }
        
        group.enter()
        apiQueue.async {
            self.fetchForecast(location: location) { (result) in
                switch result {
                case .success(let data):
                    self.forecast = data
                default:
                    self.forecast = nil
                }
                self.group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
}

extension WeatherDataSource {
    
    private func fetch<ParsingType:Codable> (urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()) {
        guard let url = URL(string: urlStr) else {
    //        fatalError("URL 생성 실패")
            completion(.failure(ApiError.invalidUrl(urlStr)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
    //            fatalError(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
    //            fatalError("invalid response")
                completion(.failure(ApiError.invaildResponse))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
    //            fatalError("failed code \(httpResponse.statusCode)")
                completion(.failure(ApiError.failed(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
    //            fatalError("empty data")
                completion(.failure(ApiError.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(ParsingType.self, from: data)
                
                completion(.success(data))

            } catch {
    //            fatalError(error.localizedDescription)
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    private func fetchCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&lang=kr&units=metric"

        fetch(urlStr: urlStr, completion: completion)
    }

    private func fetchCurrentWeather(cityId: Int, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(apiKey)&lang=kr&units=metric"

        fetch(urlStr: urlStr, completion: completion)
    }

    private func fetchCurrentWeather(location: CLLocation, completion: @escaping (Result<CurrentWeather, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&lang=kr&units=metric"

        fetch(urlStr: urlStr, completion: completion)
    }
}

extension WeatherDataSource {
    
    private func fetchForecast(cityName: String, completion: @escaping (Result<Forecast, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(apiKey)&lang=kr&units=metric"

        fetch(urlStr: urlStr, completion: completion)
    }

    private func fetchForecast(cityId: Int, completion: @escaping (Result<Forecast, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&appid=\(apiKey)&lang=kr&units=metric"

        fetch(urlStr: urlStr, completion: completion)
    }

    private func fetchForecast(location: CLLocation, completion: @escaping (Result<Forecast, Error>) -> ()) {
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&lang=kr&units=metric"

        fetch(urlStr: urlStr, completion: completion)
    }
}
