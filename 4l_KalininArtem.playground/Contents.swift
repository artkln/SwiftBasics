import UIKit

enum CarActions {
    case startEndine
    case turnOffEngine
    case openWindows
    case closeWindows
    case openDoors
    case closeDoors
    case loadCargo(cargoVolume: Double)
    case unloadCargo(cargoVolume: Double)
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

class Car {
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
    
    init(brand: String,
         yearOfManufacture: UInt16,
         engineState: CarEngineState,
         windowsState: CarWindowsState,
         doorState: DoorState) {
        
        self.brand = brand
        self.yearOfManufacture = yearOfManufacture
        self.engineState = engineState
        self.windowsState = windowsState
        self.doorState = doorState
    }
    
    func printInfo() {
        print("Марка: \(brand)")
        print("Год выпуска: \(yearOfManufacture)")
        print("Состояние двигателя: \(engineState.rawValue)")
        print("Состояние окон: \(windowsState.rawValue)")
        print("Состояние дверей: \(doorState.rawValue)")
    }
    
    func performAction(action: CarActions) {}
}

class SportCar: Car {

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
        
        self.transmission = transmission
        self.maxSpeed = maxSpeed
        self.parkingSensor = parkingSensor
        self.spoiler = spoiler
        
        super.init(brand: brand,
                   yearOfManufacture: yearOfManufacture,
                   engineState: engineState,
                   windowsState: windowsState,
                   doorState: doorState)
    }
    
    override func printInfo() {
        print("Легковой автомобиль")
        super.printInfo()
        print("Коробка передач: \(transmission.rawValue)")
        print("Максимальная скорость: \(maxSpeed) км/ч")
        print("Наличие парктроника:", terminator: " ")
        parkingSensor ? print("Встроен") : print("Отсутствует")
        print("Наличие спойлера:", terminator: " ")
        spoiler ? print("Имеется") : print("Отсутствует")
    }
    
    override func performAction(action: CarActions) {
        switch action {
        case .startEndine:
            engineState = .started
        case .turnOffEngine:
            engineState = .turnedOff
        case .openWindows:
            windowsState = .opened
        case .closeWindows:
            windowsState = .closed
        case .openDoors:
            doorState = .opened
        case .closeDoors:
            doorState = .closed
        default:
            return
        }
    }
}

class TrunkCar: Car {
    
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
        
        self.trunkVolume = trunkVolume
        self.filledTrunkVolume = filledTrunkVolume 
        self.trailer = trailer
        self.spareWheel = spareWheel
        
        super.init(brand: brand,
                   yearOfManufacture: yearOfManufacture,
                   engineState: engineState,
                   windowsState: windowsState,
                   doorState: doorState)
    }
    
    override func printInfo() {
        print("Грузовой автомобиль")
        super.printInfo()
        print("Объем багажника: \(trunkVolume) л")
        print("Заполненный объем багажника: \(filledTrunkVolume) л")
        print("Размер прицепа: \(trailer.rawValue)")
        print("Наличие запасного колеса:", terminator: " ")
        spareWheel ? print("Имеется") : print("Отсутствует")
    }
    
    override func performAction(action: CarActions) {
        switch action {
        case .startEndine:
            engineState = .started
        case .turnOffEngine:
            engineState = .turnedOff
        case .openWindows:
            windowsState = .opened
        case .closeWindows:
            windowsState = .closed
        case .openDoors:
            doorState = .opened
        case .closeDoors:
            doorState = .closed
        case let .loadCargo(cargoVolume: volume):
            print("Загружаем багажник")
            if volume + filledTrunkVolume > trunkVolume {
                print("В кузове нет достаточного места для погрузки!")
            } else {
                filledTrunkVolume += volume
            }
        case let .unloadCargo(cargoVolume: volume):
            print("Разгружаем багажник")
            if filledTrunkVolume - volume < 0 {
                print("В кузове нет достаточного объема груза для разгрузки!")
            } else {
                filledTrunkVolume -= volume
            }
        }
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

sportCar1.printInfo()
print("\n")
sportCar1.performAction(action: .openDoors)
sportCar1.performAction(action: .startEndine)
sportCar1.performAction(action: .openWindows)
print("\n")
sportCar1.printInfo()

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

sportCar2.printInfo()
print("\n")
sportCar2.performAction(action: .closeWindows)
sportCar2.performAction(action: .closeDoors)
print("\n")
sportCar2.printInfo()

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

trunkCar1.printInfo()
print("\n")
trunkCar1.performAction(action: .loadCargo(cargoVolume: 4200))
trunkCar1.performAction(action: .turnOffEngine)
trunkCar1.performAction(action: .closeWindows)
trunkCar1.performAction(action: .closeDoors)
print("\n")
trunkCar1.printInfo()

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

trunkCar2.printInfo()
print("\n")
trunkCar2.performAction(action: .unloadCargo(cargoVolume: 17000))
print("\n")
trunkCar2.printInfo()

print("\n------------------------------\n")
