import UIKit

let a: Double = 4.0
let b: Double = 4.0
let c: Double = 0.0
var x1: Double
var x2: Double
if a == 0 {
    print("Ошибка: задано линейное уравнение!")
} else {
    if b == 0 && c > 0 {
        print("Уравнение не имеет корней!")
    } else {
        let discriminant = pow(b, 2) - 4 * a * c
        if discriminant < 0 {
            print("Уравнение не имеет корней!")
        } else if discriminant == 0 {
            x1 = b == 0 && c == 0 ? 0 : -b / (2 * a)
            print("Уравнение имеет один корень: x = \(round(100 * x1) / 100)")
        } else {
            x1 = (-b + sqrt(discriminant)) / (2 * a)
            x2 = (-b - sqrt(discriminant)) / (2 * a)
            print("Уравнение имеет два корня: x1 = \(round(100 * x1) / 100), x2 = \(round(100 * x2) / 100)")
        }
    }
}
