import Foundation

struct CalculatorBrain {
    
    var bmi : Float = 0.0
    
    mutating func calculateBMI(height: Float, weight: Float){
        bmi = weight / (height * height)
    }
    
    func getBMIValue() -> String {
        let bmiString = String(format: "%.1f", bmi)
        return bmiString
    }
}
