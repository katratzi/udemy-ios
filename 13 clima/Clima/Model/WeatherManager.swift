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
            
            // 3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            
            // 4. Start the task
            task.resume()
        } else {
            print("url went wrong")
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil{
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: String.Encoding.utf8)
            print(dataString!)
        }
    }
}
