import UIKit

struct CalculatorBrain {
    
    var bmi : BMI?
    
    
    func getBMIValue() -> String {
        let bmiString = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiString
    }
    
    mutating func calculateBMI(height: Float, weight: Float){
        
        // get this with #colorLiteral()
        let colors = (underweight: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), healthy: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), overweight: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) )
        let bmiValue = weight / (height * height)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies", color: colors.underweight)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle", color: colors.healthy)
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies", color: colors.overweight)
        }
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.gray
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "just keep swimming"
    }
    
}
