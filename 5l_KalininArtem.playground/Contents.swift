import UIKit

enum CarActions {
    case startEndine
    case turnOffEngine
    case openWindows
    case closeWindows
    case openDoors
    case closeDoors
}

enum CarEngineState: String {
    case started = "Заведен"
    case turnedOff = "Заглушен"
}

enum CarWindowsState: String {
    case opened = "Открыты"
    case closed = "Закрыты"
}

enum DoorState: String {
    case opened = "Открыты"
    case closed = "Закрыты"
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
    var brand: String { get set }
    var yearOfManufacture: UInt16 { get set }
    var engineState: CarEngineState { get set }
    var windowsState: CarWindowsState { get set }
    var doorState: DoorState { get set }
    
    func startEngine()
    func turnOffEngine()
    func openWindows()
    func closeWindows()
    func openDoors()
    func closeDoors()
}

extension Car {
    func startEngine() {
        engineState = .started
    }
    
    func turnOffEngine() {
        engineState = .turnedOff
    }
    
    func openWindows() {
        windowsState = .opened
    }
    
    func closeWindows() {
        windowsState = .closed
    }
    
    func openDoors() {
        doorState = .opened
    }
    
    func closeDoors() {
        doorState = .closed
    }
}

class SportCar: Car {

    var brand: String
    var yearOfManufacture: UInt16
    var engineState: CarEngineState {
        willSet {
            if newValue == .started {
                print("Заводим двигатель")
            } else {
                print("Глушим двигатель")
            }
        }
    }
    var windowsState: CarWindowsState {
        willSet {
            if newValue == .opened {
                print("Открываем окна")
            } else {
                print("Закрываем окна")
            }
        }
    }
    var doorState: DoorState {
        willSet {
            if newValue == .opened {
                print("Открываем двери")
            } else {
                print("Закрываем двери")
            }
        }
    }
    
    var transmission: Transmission
    var maxSpeed: Double
    var parkingSensor: Bool
    var spoiler: Bool
    
    init(brand: String,
         yearOfManufacture: UInt16,
         engineState: CarEngineState,
         windowsState: CarWindowsState,
         doorState: DoorState,
         transmission: Transmission,
         maxSpeed: Double,
         parkingSensor: Bool,
         spoiler: Bool) {
        
        self.brand = brand
        self.yearOfManufacture = yearOfManufacture
        self.engineState = engineState
        self.windowsState = windowsState
        self.doorState = doorState
        self.transmission = transmission
        self.maxSpeed = maxSpeed
        self.parkingSensor = parkingSensor
        self.spoiler = spoiler
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return """
            \nЛегковой автомобиль
            Марка: \(brand)
            Год выпуска: \(yearOfManufacture)
            Состояние двигателя: \(engineState.rawValue)
            Состояние окон: \(windowsState.rawValue)
            Состояние дверей: \(doorState.rawValue)
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
    var engineState: CarEngineState {
        willSet {
            if newValue == .started {
                print("Заводим двигатель")
            } else {
                print("Глушим двигатель")
            }
        }
    }
    var windowsState: CarWindowsState {
        willSet {
            if newValue == .opened {
                print("Открываем окна")
            } else {
                print("Закрываем окна")
            }
        }
    }
    var doorState: DoorState {
        willSet {
            if newValue == .opened {
                print("Открываем двери")
            } else {
                print("Закрываем двери")
            }
        }
    }
    
    var trunkVolume: Double
    var filledTrunkVolume: Double
    var trailer: Trailer
    var spareWheel: Bool
    
    init(brand: String,
         yearOfManufacture: UInt16,
         engineState: CarEngineState,
         windowsState: CarWindowsState,
         doorState: DoorState,
         trunkVolume: Double,
         filledTrunkVolume: Double,
         trailer: Trailer,
         spareWheel: Bool) {
        
        self.brand = brand
        self.yearOfManufacture = yearOfManufacture
        self.engineState = engineState
        self.windowsState = windowsState
        self.doorState = doorState
        self.trunkVolume = trunkVolume
        self.filledTrunkVolume = filledTrunkVolume
        self.trailer = trailer
        self.spareWheel = spareWheel
    }
    
    func loadCargo(cargoVolume: Double) {
        print("Загружаем багажник")
        if cargoVolume + filledTrunkVolume > trunkVolume {
            print("В кузове нет достаточного места для погрузки!")
        } else {
            filledTrunkVolume += cargoVolume
        }
    }
    
    func unloadCargo(cargoVolume: Double) {
        print("Разгружаем багажник")
        if filledTrunkVolume - cargoVolume < 0 {
            print("В кузове нет достаточного объема груза для разгрузки!")
        } else {
            filledTrunkVolume -= cargoVolume
        }
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
            \nГрузовой автомобиль
            Марка: \(brand)
            Год выпуска: \(yearOfManufacture)
            Состояние двигателя: \(engineState.rawValue)
            Состояние окон: \(windowsState.rawValue)
            Состояние дверей: \(doorState.rawValue)
            Объем багажника: \(trunkVolume) л
            Заполненный объем багажника: \(filledTrunkVolume) л
            Размер прицепа: \(trailer.rawValue)
            Наличие запасного колеса: \(spareWheel ? "Имеется\n" : "Отсутствует\n")
            """
    }
}

var sportCar1 = SportCar(brand: "Skoda",
                         yearOfManufacture: 2002,
                         engineState: .turnedOff,
                         windowsState: .closed,
                         doorState: .closed,
                         transmission: .manual,
                         maxSpeed: 180,
                         parkingSensor: true,
                         spoiler: false)

print(sportCar1)
sportCar1.openDoors()
sportCar1.startEngine()
sportCar1.openWindows()
print(sportCar1)

print("\n------------------------------\n")


var sportCar2 = SportCar(brand: "BMW",
                         yearOfManufacture: 2015,
                         engineState: .turnedOff,
                         windowsState: .opened,
                         doorState: .opened,
                         transmission: .auto,
                         maxSpeed: 220,
                         parkingSensor: false,
                         spoiler: true)

print(sportCar2)
sportCar2.closeWindows()
sportCar2.closeDoors()
print(sportCar2)

print("\n------------------------------\n")


var trunkCar1 = TrunkCar(brand: "MAN",
                         yearOfManufacture: 2003,
                         engineState: .started,
                         windowsState: .opened,
                         doorState: .closed,
                         trunkVolume: 9000,
                         filledTrunkVolume: 2836,
                         trailer: .big,
                         spareWheel: false)

print(trunkCar1)
trunkCar1.loadCargo(cargoVolume: 4200)
trunkCar1.turnOffEngine
trunkCar1.closeWindows
trunkCar1.closeDoors
print(trunkCar1)

print("\n------------------------------\n")
    

var trunkCar2 = TrunkCar(brand: "Volvo",
                         yearOfManufacture: 2012,
                         engineState: .turnedOff,
                         windowsState: .closed,
                         doorState: .opened,
                         trunkVolume: 32000,
                         filledTrunkVolume: 250,
                         trailer: .small,
                         spareWheel: true)

print(trunkCar2)
trunkCar2.unloadCargo(cargoVolume: 17000)
print(trunkCar2)

print("\n------------------------------\n")
