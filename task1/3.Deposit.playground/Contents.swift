import Darwin
var deposit: Double = 2000
let percentage: Double = 5
for _ in 1 ... 5 {
    deposit = deposit * (1 + percentage / 100)
}
print("Сумма вклада через 5 лет: \(round(100 * deposit) / 100)")

