import UIKit

var greeting = "Hello, playground"



func Fibonacci(n: Int) -> [Int]{
    
    var toReturn: [Int] = [0, 1]
    
    for i in  2..<n{
        toReturn.append(toReturn[i - 1] + toReturn[i - 2])
    }

    return toReturn
}


Fibonacci(n: 10)
