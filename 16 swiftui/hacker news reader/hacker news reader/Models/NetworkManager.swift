//
//  NetworkManager.swift
//  hacker news reader
//
//  Created by Richard Clifford on 24/02/2023.
//

import Foundation

class NetworkManager {
    
    func fetchData() {
       if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page")
        {
           let session = URLSession(configuration: .default)
           let task = session.dataTask(with: url) { data, response
               , error in
               if error == nil {
                   let decoder = JSONDecoder()
                   if let safeData = data {
                       do {
                         let results = try decoder.decode(Results.self, from: safeData)
                       } catch {
                           print(error)
                       }
                   }
               }
           }
           
           task.resume()
       }
    }
}
