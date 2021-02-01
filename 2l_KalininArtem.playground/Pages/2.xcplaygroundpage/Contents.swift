//: [Previous](@previous)

import UIKit

func mod3(_ number: Int) -> Bool {
    if number % 3 == 0 {
        return true
    } else {
        return false
    }
}

let n = 37

if mod3(n) {
    print("Число делится на 3 без остатка")
} else {
    print("Число не делится на 3 без остатка")
}

//: [Next](@next)
