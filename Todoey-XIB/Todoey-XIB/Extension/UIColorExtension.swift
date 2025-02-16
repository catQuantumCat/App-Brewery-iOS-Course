//
//  UIColorExt+Randomize.swift
//  Todoey-XIB
//
//  Created by Huy on 12/2/25.
//
import UIKit

public extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}


extension UIColor {
    // Returns either black or white depending on the background color's brightness
    var contrastColor: UIColor {
        // Convert to RGB space and get components including alpha
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Get color components in RGB space
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            
            if alpha < 1.0 {
            
                red = (alpha * red) + (1 - alpha) * 1.0
                green = (alpha * green) + (1 - alpha) * 1.0
                blue = (alpha * blue) + (1 - alpha) * 1.0
            }
            
            let brightness = (0.299 * red + 0.587 * green + 0.114 * blue)
            return brightness > 0.6 ? .black : .white
        }
        
        return .black // Default fallback
    }
}


//MARK: - HEX CONVERTION
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }

        return nil
    }
    var hexString : String{
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        

        let hexString = String(format: "#%02x%02x%02x", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
    }
}
