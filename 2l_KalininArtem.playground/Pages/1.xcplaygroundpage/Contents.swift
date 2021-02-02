import UIKit

func oddEven(number: Int) -> Bool { number % 2 == 0 }

let n = 456

if oddEven(number: n) {
    print("Число чётное")
} else {
    print("Число нечётное")
}

