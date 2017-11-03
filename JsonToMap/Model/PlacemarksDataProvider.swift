//
//  DataService.swift
//  JsonToMap
//
//  Created by André Niet on 25.10.17.
//  Copyright © 2017 André Niet. All rights reserved.
//

import Foundation

class PlacemarksDataProvider {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var carViewModel: PlacemarkViewModel?
    var errorMessage = ""
    
    /// Request json data from server by http request
    ///
    /// - Parameter completion: completion handler called when request has completed
    /// - Parameter url: url like https://www.yourdomain.com/data.json
    func requestData(withURL url: String, completion: @escaping Result) {
        let url = URL(string: url)!
        let urlSession = URLSession(configuration: .default)
        dataTask = urlSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateResults(data: data)
                
                DispatchQueue.main.async {
                    completion(self.carViewModel, self.errorMessage)
                }
            }
        }
        
        dataTask?.resume()
    }
    
    /// Request local json data from server by http request
    ///
    /// - Parameter completion: completion handler called when request has completed
    func requestData(completion: @escaping Result) {
        let urlpath = Bundle.main.path(forResource: "locations", ofType: "json")
        let url = URL(fileURLWithPath: urlpath!)
        let urlSession = URLSession(configuration: .default)
        dataTask = urlSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data {
                self.updateResults(data: data)
                
                DispatchQueue.main.async {
                    completion(self.carViewModel, self.errorMessage)
                }
            }
        }
        
        dataTask?.resume()
    }
    
    
    /// Update result data
    ///
    /// - Parameter data: The data from the server
    func updateResults(data: Data) {
        do {
            let jsonDecoder = JSONDecoder()
            carViewModel = try jsonDecoder.decode(PlacemarkViewModel.self, from: data)
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.debugDescription)\n"
            return
        }
    }
}
