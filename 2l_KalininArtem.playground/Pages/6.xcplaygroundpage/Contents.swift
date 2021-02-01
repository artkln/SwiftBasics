//: [Previous](@previous)

import UIKit

var array: [Int] = []
let n = 541
var p = 2
var flag = true

for i in 2...n {
    array.append(i)
}

while flag == true {
    for value in stride(from: 2 * p, through: n, by: p) {
        if let test = array.firstIndex(of: value) {
            array.remove(at: array.firstIndex(of: value)!)
        }
    }

    for (index, value) in array.enumerated() {
        if value > p {
            p = value
            break
        } else if index == array.count - 1 {
            flag = false
        }
    }
}

print(array.count)
print(array)

//: [Next](@next)
