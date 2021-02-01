//: [Previous](@previous)

import UIKit

func addFib(_ array: inout [Int]) {
    array.append(array[array.count - 2] + array[array.count - 1])
}

var array: [Int] = [1, 2]

for _ in 0...49 {
    addFib(&array)
}

print(array.count) //50 элементов добавлено, 52 вместе с первыми двумя числами
print(array)

//: [Next](@next)
