import UIKit

enum CarDoorType: String {
    case twoDoors = "Двухдверхный"
    case fourDoors = "Четырехдверный"
}

enum Trailer: String {
    case small = "Маловместительный"
    case big = "Вместительный"
}

enum Transmission: String {
    case auto = "Автомат"
    case manual = "Механика"
}

protocol Car: class {
    var brand: String { get }
    var yearOfManufacture: UInt16 { get }
    var doorType: CarDoorType { get }
    var transmission: Transmission { get }
}

class SportCar: Car {

    var brand: String
    var yearOfManufacture: UInt16
    var doorType: CarDoorType
    var transmission: Transmission
    var maxSpeed: Double
    var parkingSensor: Bool
    var spoiler: Bool
    
    init(brand: String,
         yearOfManufacture: UInt16,
         doorType: CarDoorType,
         transmission: Transmission,
         maxSpeed: Double,
         parkingSensor: Bool,
         spoiler: Bool) {
        
        self.brand = brand
        self.yearOfManufacture = yearOfManufacture
        self.doorType = doorType
        self.transmission = transmission
        self.maxSpeed = maxSpeed
        self.parkingSensor = parkingSensor
        self.spoiler = spoiler
    }
    
    convenience init(brand: String,
                     yearOfManufacture: UInt16,
                     transmission: Transmission) {
        
        self.init(brand: brand,
                  yearOfManufacture: yearOfManufacture,
                  doorType: CarDoorType.fourDoors,
                  transmission: transmission,
                  maxSpeed: 200,
                  parkingSensor: true,
                  spoiler: false)
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return """
            \nЛегковой автомобиль
            Марка: \(brand)
            Год выпуска: \(yearOfManufacture)
            Тип по количеству дверей: \(doorType.rawValue)
            Коробка передач: \(transmission.rawValue)
            Максимальная скорость: \(maxSpeed) км/ч
            Наличие парктроника: \(parkingSensor ? "Встроен" : "Отсутствует")
            Наличие спойлера: \(spoiler ? "Имеется\n" : "Отсутствует\n")
            """
    }
}

class TrunkCar: Car {
    
    var brand: String
    var yearOfManufacture: UInt16
    var doorType: CarDoorType
    var transmission: Transmission
    var trailer: Trailer
    var spareWheel: Bool
    
    init(brand: String,
         yearOfManufacture: UInt16,
         doorType: CarDoorType,
         transmission: Transmission,
         trailer: Trailer,
         spareWheel: Bool) {
        
        self.brand = brand
        self.yearOfManufacture = yearOfManufacture
        self.doorType = doorType
        self.transmission = transmission
        self.trailer = trailer
        self.spareWheel = spareWheel
    }
    
    convenience init(brand: String,
                      yearOfManufacture: UInt16) {
        
        self.init(brand: brand,
                  yearOfManufacture: yearOfManufacture,
                  doorType: CarDoorType.twoDoors,
                  transmission: .manual,
                  trailer: Trailer.big,
                  spareWheel: true)
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
                \nГрузовой автомобиль
                Марка: \(brand)
                Год выпуска: \(yearOfManufacture)
                Тип по количеству дверей: \(doorType.rawValue)
                Коробка передач: \(transmission.rawValue)
                Размер прицепа: \(trailer.rawValue)
                Наличие запасного колеса: \(spareWheel ? "Имеется\n" : "Отсутствует\n")
                """
    }
}

struct Queue<T> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        guard elements.count > 0 else { return nil }
        return elements.removeFirst()
    }
    
    func printInfo() {
        elements.forEach { print($0) }
    }
    
    let filterBySportType: (T) -> Bool = { $0 is SportCar }
    
    let filterByTrunkType: (T) -> Bool = { $0 is TrunkCar }
    
    let filterByBMW: (T) -> Bool = { element in
        if let test = element as? SportCar {
            return test.brand == "BMW"
        } else {
            return false
        }
    }
    
    let filterByYear: (T) -> Bool = { element in
        if let test = element as? Car {
            return test.yearOfManufacture > 2002
        } else {
            return false
        }
    }
    
    let filterByTransmission: (T) -> Bool = { element in
        if let test = element as? Car {
            return test.transmission == .manual
        } else {
            return false
        }
    }
    
    let filterByTrailer: (T) -> Bool = { element in
        if let test = element as? TrunkCar {
            return test.trailer == .small
        } else {
            return false
        }
    }
}

extension Queue {
    subscript(indices: Int) -> T? {
        guard indices >= 0 && indices < elements.count else {
            return nil
        }
        
        return elements[indices]
    }
    
    func filter(predicate: (T) -> Bool) -> [T] {
        var tmpArray = [T]()
        for element in elements {
            if predicate(element) {
                tmpArray.append(element)
            }
        }
        return tmpArray
    }
}

var queue = Queue<Car>()

var trunkCar1 = TrunkCar(brand: "Iveco", yearOfManufacture: 2002)
var sportCar1 = SportCar(brand: "Suzuki", yearOfManufacture: 2021, transmission: .manual)
var sportCar2 = SportCar(brand: "BMW", yearOfManufacture: 2009, transmission: .auto)
var sportCar3 = SportCar(brand: "Mercedes", yearOfManufacture: 2020, transmission: .auto)
var trunkCar2 = TrunkCar(brand: "MAN", yearOfManufacture: 2017)
var trunkCar3 = TrunkCar(brand: "GAZ", yearOfManufacture: 2008)
var sportCar4 = SportCar(brand: "BMW", yearOfManufacture: 2000, doorType: .twoDoors, transmission: .manual, maxSpeed: 190, parkingSensor: false, spoiler: false)
var trunkCar4 = TrunkCar(brand: "Volvo", yearOfManufacture: 2015, doorType: .twoDoors, transmission: .manual, trailer: .small, spareWheel: false)


print("Работа очереди:")
print("-Добавляем элементы-")
queue.push(trunkCar1)
queue.push(sportCar1)
queue.push(sportCar2)
queue.push(sportCar3)
queue.push(trunkCar2)
queue.push(trunkCar3)
queue.push(sportCar4)
queue.push(trunkCar4)
queue.printInfo()

print("-Удаляем элемент-")
queue.pop()
queue.printInfo()

print("-Удаляем элемент-")
queue.pop()
queue.printInfo()

print("-----------------------------------")
print("-Получаем элемент по индексу 3-")
if let test = queue[3] {
    print(test)
} else {
    print("Элемента с таким  индексом нет в массиве!")
}

print("-----------------------------------")
print("-Получаем элемент по индексу 8-")
if let test = queue[8] {
    print(test)
} else {
    print("\nЭлемента с таким  индексом нет в массиве!")
}

print("-----------------------------------")
print("-Фильтруем очередь по типу автомобиля (легковой)-")
var result: [Car] = queue.filter(predicate: queue.filterBySportType)
result.forEach() { print($0) }

print("-----------------------------------")
print("-Фильтруем очередь по типу автомобиля (грузовой)-")
result = queue.filter(predicate: queue.filterByTrunkType)
result.forEach() { print($0) }

print("-----------------------------------")
print("-Фильтруем очередь по марке автомобиля (BMW)-")
result = queue.filter(predicate: queue.filterByBMW)
result.forEach() { print($0) }

print("-----------------------------------")
print("-Фильтруем очередь по году выпуска автомобиля (старше 2002)-")
result = queue.filter(predicate: queue.filterByYear)
result.forEach() { print($0) }

print("-----------------------------------")
print("-Фильтруем очередь по коробке передач автомобиля (механика)-")
result = queue.filter(predicate: queue.filterByTransmission)
result.forEach() { print($0) }

print("-----------------------------------")
print("-Фильтруем очередь по размеру прицепа автомобиля (малый)-")
result = queue.filter(predicate: queue.filterByTrailer)
result.forEach() { print($0) }
