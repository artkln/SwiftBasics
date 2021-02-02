//: [Previous](@previous)

import UIKit

func oddEven(number: Int) -> Bool { number % 2 == 0 }

func mod3(_ number: Int, dividedBy divider: Int) -> Bool { number % divider == 0 }

var array: [Int] = []
for i in stride(from: 0, to: 500, by: 5) {
    array.append(i)
}

for value in array {
    if oddEven(number: value) || !mod3(value, dividedBy: 3) {
        if let index = array.firstIndex(of: value) {
            array.remove(at: index)
        }
    }
}

print(array.count)
print(array)

//: [Next](@next)
