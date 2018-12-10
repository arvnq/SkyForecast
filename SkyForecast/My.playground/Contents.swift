import UIKit
import Foundation

var str = "Hello, playground"

extension String {
    //    static func degree(_ temperatureType: String?) -> String {
    //
    //    }
    
//    static var degree = { () -> String in
//        return "temp"
//    }
//
    
}

var closure = { (_ temp: String) -> (String) in
    return temp
}

let x = closure("")
print(x)



let y = NSString(format:"23%@", "\u{00B0}") as String
print(y)

let z = "131\u{00B0}"
print(z)
