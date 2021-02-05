import UIKit

enum CarActions {
    case startEndine, turnOffEngine
    case openWindows, closeWindows
    case loadCargo(cargoVolume: Double), unloadCargo(cargoVolume: Double)
}

enum CarEngineState: String {
    case started = "Заведен"
    case turnedOff = "Заглушен"
}

enum CarWindowsState: String {
    case opened = "Открыты"
    case closed = "Закрыты"
}

struct SportCar {
    private var brand: String
    private var yearOfManufacture: UInt16
    private let trunkVolume: Double
    private var filledTrunkVolume: Double
    private var engineState: CarEngineState {
        willSet {
            if newValue == .started {
                print("Заводим двигатель")
            } else {
                print("Глушим двигатель")
            }
        }
    }
    
    private var windowsState: CarWindowsState {
        willSet {
            if newValue == .opened {
                print("Открываем окна")
            } else {
                print("Закрываем окна")
            }
        }
    }
    
    init(brand: String, yearOfManufacture: UInt16, trunkVolume: Double, filledTrunkVolume: Double, engineState: CarEngineState, windowsState: CarWindowsState) {
        self.brand = brand
        self.yearOfManufacture = yearOfManufacture
        self.trunkVolume = trunkVolume
        self.filledTrunkVolume = filledTrunkVolume
        self.engineState = engineState
        self.windowsState = windowsState
    }
    
    func printInformation() {
        print("Легковой автомобиль")
        print("Марка: \(brand)")
        print("Год выпуска: \(yearOfManufacture)")
        print("Объем багажника: \(trunkVolume) л")
        print("Заполненный объем багажника: \(filledTrunkVolume)")
        print("Состояние двигателя: \(engineState.rawValue)")
        print("Состояние окон: \(windowsState.rawValue)")
    }
    
    mutating func performAction(action: CarActions) {
        switch action {
        case .startEndine:
            engineState = .started
        case .turnOffEngine:
            engineState = .turnedOff
        case .openWindows:
            windowsState = .opened
        case .closeWindows:
            windowsState = .closed
        case let .loadCargo(cargoVolume: volume):
            if volume + filledTrunkVolume > trunkVolume {
                print("В багажнике нет достаточного места для погрузки!")
            } else {
                filledTrunkVolume += volume
            }
        case let .unloadCargo(cargoVolume: volume):
            if filledTrunkVolume - volume < 0 {
                print("В багажнике нет достаточного объема груза для разгрузки!")
            } else {
                filledTrunkVolume -= volume
            }
        }
    }
}

struct TrunkCar {
    private var brand: String
    private var yearOfManufacture: UInt16
    private let trunkVolume: Double
    private var filledTrunkVolume: Double
    
    private var engineState: CarEngineState {
        willSet {
            if newValue == .started {
                print("Заводим двигатель")
            } else {
                print("Глушим двигатель")
            }
        }
    }
    
    private var windowsState: CarWindowsState {
        willSet {
            if newValue == .opened {
                print("Открываем окна")
            } else {
                print("Закрываем окна")
            }
        }
    }
    
    init(brand: String, yearOfManufacture: UInt16, trunkVolume: Double, filledTrunkVolume: Double, engineState: CarEngineState, windowsState: CarWindowsState) {
        self.brand = brand
        self.yearOfManufacture = yearOfManufacture
        self.trunkVolume = trunkVolume
        self.filledTrunkVolume = filledTrunkVolume
        self.engineState = engineState
        self.windowsState = windowsState
    }
    
    func printInformation() {
        print("Грузовой автомобиль")
        print("Марка: \(brand)")
        print("Год выпуска: \(yearOfManufacture)")
        print("Объем багажника: \(trunkVolume) л")
        print("Заполненный объем багажника: \(filledTrunkVolume)")
        print("Состояние двигателя: \(engineState.rawValue)")
        print("Состояние окон: \(windowsState.rawValue)")
    }
    
    mutating func performAction(action: CarActions) {
        switch action {
        case .startEndine:
            engineState = .started
        case .turnOffEngine:
            engineState = .turnedOff
        case .openWindows:
            windowsState = .opened
        case .closeWindows:
            windowsState = .closed
        case let .loadCargo(cargoVolume: volume):
            if volume + filledTrunkVolume > trunkVolume {
                print("В кузове нет достаточного места для погрузки!")
            } else {
                filledTrunkVolume += volume
            }
        case let .unloadCargo(cargoVolume: volume):
            if filledTrunkVolume - volume < 0 {
                print("В кузове нет достаточного объема груза для разгрузки!")
            } else {
                filledTrunkVolume -= volume
            }
        }
    }
}


var sportCar1 = SportCar(brand: "Skoda", yearOfManufacture: 2002, trunkVolume: 250, filledTrunkVolume: 0, engineState: .turnedOff, windowsState: .closed)

sportCar1.printInformation()
print("\n")
sportCar1.performAction(action: .startEndine)
sportCar1.performAction(action: .openWindows)
print("\n")
sportCar1.printInformation()

print("\n------------------------------\n")


var sportCar2 = SportCar(brand: "BMW", yearOfManufacture: 2015, trunkVolume: 530, filledTrunkVolume: 40, engineState: .turnedOff, windowsState: .closed)

sportCar2.printInformation()
print("\n")
sportCar2.performAction(action: .loadCargo(cargoVolume: 22))
sportCar2.printInformation()

print("\n------------------------------\n")


var sportCar3 = SportCar(brand: "Opel", yearOfManufacture: 2009, trunkVolume: 300, filledTrunkVolume: 250, engineState: .started, windowsState: .closed)

sportCar3.printInformation()
print("\n")
sportCar3.performAction(action: .loadCargo(cargoVolume: 170))
print("\n")
sportCar3.printInformation()

print("\n------------------------------\n")


var trunkCar1 = TrunkCar(brand: "MAN", yearOfManufacture: 2003, trunkVolume: 9000, filledTrunkVolume: 8836, engineState: .started, windowsState: .opened)

trunkCar1.printInformation()
print("\n")
trunkCar1.performAction(action: .unloadCargo(cargoVolume: 2200))
trunkCar1.performAction(action: .turnOffEngine)
trunkCar1.performAction(action: .closeWindows)
print("\n")
trunkCar1.printInformation()

print("\n------------------------------\n")


var trunkCar2 = TrunkCar(brand: "Volvo", yearOfManufacture: 2012, trunkVolume: 32000, filledTrunkVolume: 250, engineState: .turnedOff, windowsState: .closed)

trunkCar2.printInformation()
print("\n")
trunkCar2.performAction(action: .unloadCargo(cargoVolume: 17000))
print("\n")
trunkCar2.printInformation()

print("\n------------------------------\n")
