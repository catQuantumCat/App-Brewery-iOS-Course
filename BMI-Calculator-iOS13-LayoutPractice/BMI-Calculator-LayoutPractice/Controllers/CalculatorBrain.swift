import Foundation
import UIKit


struct CalculatorBrain{
    private var bmi: BMIModel? = nil
    
}

extension CalculatorBrain{
    func getIndexBMI() -> String{
        if let bmi = bmi{
            return String(format: "%.1f", bmi.score)
        }
        
        return "0.0"
    }
    
    func getQuoteBMI() -> String{
        return bmi?.quote ?? "An error has occured"
    }
    
    func getColorBMI() -> UIColor{
        return bmi?.bgColor ?? UIColor.systemBackground
    }
    
    
    mutating func calculateBMI(weight: Float, height: Float){
        let score = weight / pow(height, 2)
        var quote: String?
        var bgColor: UIColor?
        
        switch score{
        case 0..<18.5:
            quote = "Below Average"
            bgColor = UIColor.systemBlue
        case 18.5..<25:
            quote = "Average"
            bgColor = UIColor.systemGreen
        case 25...:
            quote = "Over average"
            bgColor = UIColor.systemRed
        default:
            break
        }
        if let quote = quote, let bgColor = bgColor{
            self.bmi = BMIModel(score: score, quote: quote, bgColor: bgColor)
        }
    }
}
