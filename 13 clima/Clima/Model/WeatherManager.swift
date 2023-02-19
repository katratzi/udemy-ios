import Foundation

struct WeatherManager {
    var url = "https://api.openweathermap.org/data/2.5/weather?appid=111&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(url)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        
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
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            // 4. Start the task
            task.resume()
        } else {
            print("url went wrong")
        }
    }
    
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        
        // decode can throw an error so wrap with do and try
        do {
            // use the .self to turn into a Type
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
}
