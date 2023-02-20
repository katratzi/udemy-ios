import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate : WeatherManagerDelegate?
    
    var url = "https://api.openweathermap.org/data/2.5/weather?appid=111&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(url)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
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
                    if let weather = self.parseJSON(safeData)
                    {
                        self.delegate?.didUpdateWeather(self,  weather: weather)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        } else {
            print("url went wrong")
        }
    }
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        // decode can throw an error so wrap with do and try
        do {
            // use the .self to turn into a Type
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel (conditionId: id, cityName: name, temperature: temp)
            
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
