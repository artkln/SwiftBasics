import Darwin
let a: Double = 2
let b: Double = 3
let square = 0.5 * a * b
let c = sqrt(pow(a, 2) + pow(b, 2))
let perimeter = a + b + c
print("Площадь треугольника: S = \(round(100 * square) / 100)")
print("Гипотенуза треугольника: c = \(round(100 * c) / 100)")
print("Периметр треугольника: P = \(round(100 * perimeter) / 100)")


