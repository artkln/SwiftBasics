import UIKit

func oddEven(number: Int) -> Bool {
    if number % 2 == 0 {
        return true
    } else {
        return false
    }
}

let n = 456

if oddEven(number: n) {
    print("Число чётное")
} else {
    print("Число нечётное")
}

