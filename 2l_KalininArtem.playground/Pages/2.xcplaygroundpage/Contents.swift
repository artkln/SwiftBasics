//: [Previous](@previous)

import UIKit

func mod3(_ number: Int, dividedBy divider: Int) -> Bool { number % divider == 0 }

let n = 37

if mod3(n, dividedBy: 3) {
    print("Число делится на 3 без остатка")
} else {
    print("Число не делится на 3 без остатка")
}

//: [Next](@next)
