//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

//By convention, Swift protocols are usually written in the file that has the class/struct which will call the
//delegate methods, i.e. the CoinManager.
protocol CoinManagerDelegate {
    
    //Create the method stubs wihtout implementation in the protocol.
    //It's usually a good idea to also pass along a reference to the current class.
    //e.g. func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String)
    //Check the Clima module for more info on this.
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "YOUR_API_KEY_HERE"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = [
        "AUD", "BRL","CAD","CNY","EUR","GBP","HKD",
        "IDR","ILS","INR","JPY","MXN","NOK","NZD",
        "PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String){
        
        let urlString = "\(baseURL)\(currency)/?apikey=\(apiKey)"
        
        let trimmed = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 1. Create a url
        if let url = URL(string: trimmed){
            
            // 2. Create a session
            let session = URLSession(configuration: .default)
            print(url)
            
            // 3. Give the session a task
            // this uses a trailing closure
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    // let outputStr  = String(data: safeData, encoding: String.Encoding.utf8)
                    // print(outputStr!)
                    if let safeRate = self.parseJSON(safeData)
                    {
                        let roundedRate = String(format: "%.2f", safeRate)
                        self.delegate?.didUpdatePrice(price: roundedRate, currency: currency)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        } else {
            print("url went wrong")
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func parseJSON(_ coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        
        // decode can throw an error so wrap with do and try
        do {
            // use the .self to turn into a Type
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            print(rate)
            return rate
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
