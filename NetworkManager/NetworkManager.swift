//
//  NetworkManager.swift
//  BusApp
//
//  Created by REEMOTTO on 25.08.22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let apiKey = "apikey 6BjX7Ke7RdMK4VhU6SligM:1HmCNMGnc5AndPWqAv86ya"
    let stringURL = "https://api.collectapi.com/gasPrice/fromCoordinates"
    
    func getGasolinePrice(long: Double, lat: Double, completion: @escaping (Gasoline?) -> Void) {
        
        guard let url = URL(string: stringURL + "?lng=\(long)&lat=\(lat)") else { return }
        
        let headers = [
            "content-type": "application/json",
            "authorization": apiKey
        ]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let gasoline = try JSONDecoder().decode(Gasoline.self, from: data)
                completion(gasoline)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}
