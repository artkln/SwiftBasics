//: [Previous](@previous)

import UIKit

func oddEven(number: Int) -> Bool {
    if number % 2 == 0 {
        return true
    } else {
        return false
    }
}

func mod3(_ number: Int) -> Bool {
    if number % 3 == 0 {
        return true
    } else {
        return false
    }
}

var array: [Int] = []
for i in stride(from: 0, to: 500, by: 5) {
    array.append(i)
}

for value in array {
    if oddEven(number: value) || !mod3(value) {
        array.remove(at: array.firstIndex(of: value)!)
    }
}

print(array.count)
print(array)

//: [Next](@next)
