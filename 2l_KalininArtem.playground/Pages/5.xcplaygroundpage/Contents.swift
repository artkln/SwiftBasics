//: [Previous](@previous)

import UIKit

typealias Fibonacci = Decimal

func addFib(_ array: inout [Fibonacci]) {
    switch array.count {
    case 0, 1:
        array.append(1)
    default:
        array.append(array[array.count - 2] + array[array.count - 1])
    }
}

var array: [Fibonacci] = []

for _ in 0...99 {
    addFib(&array)
}

print(array.count)
print(array)

//: [Next](@next)
