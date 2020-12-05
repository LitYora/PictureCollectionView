//
//  NetworkService.swift
//  PictureCollectionView
//
//  Created by Matvei  on 01.12.2020.
//

import Foundation

class NetworkService {
    
    static func loadData(completion: @escaping ([MLines], Error?) -> Void) {
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 13
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "https://api.hh.ru/metro/1") else {
            let error = NSError(domain: "Invalid code", code: -123, userInfo: nil)
            completion([], error)
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion([], error)
                }
                return
            }
            
            let response = response as! HTTPURLResponse
            guard let data = data else{
                let error = NSError(domain: "Data Error Occures. Responce Code: \(response.statusCode)", code: response.statusCode, userInfo: nil)
                DispatchQueue.main.async {
                    completion([], error)
            }
                print("Data Error occured. Responce status code: \(response.statusCode)")
                return
        }
        
            
            do{
                    
                let serverResult = try JSONDecoder().decode(ServerJSON.self, from: data)
//                completion(serverResult.lines, nil)
                let lines = serverResult.lines
                
                DispatchQueue.main.async {
                    completion(lines, nil)
                }
            }
            
            catch (let jsonError) {
                
                print(jsonError)
                DispatchQueue.main.async {
                completion([], jsonError)
                }
            }
    }
        task.resume()
    }
}
