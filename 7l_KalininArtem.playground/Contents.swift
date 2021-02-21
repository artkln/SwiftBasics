import UIKit

enum AppointmentError: Error {
    case invalidSelection
    case longQueue
    case insufficientFunds(fundsNeeded: Int)
    
    var descriprion: String {
        switch self {
        case .invalidSelection:
            return "Врача на выбранной должности нет в клинике"
        case let .insufficientFunds(fundsNeeded: fundsNeeded):
            return "Для записи на приём недостаточно средств в размере \(fundsNeeded) рублей"
        case .longQueue:
            return "На приём к выбранному доктору слишком большая очередь (больше 10 человек). Попробуйте записаться позднее"
        }
    }
}

enum ChangeError: Error {
    case alreadyExists
    case priceTooHigh
}

struct Doctor {
    let fio: Fio
    let queue: Int
    var price: Int
    let position: String
}

struct Fio {
    let name: String
    let surname: String
    let patronymic: String?
}

class Clinic {
    
    var list = [
        "Педиатр": Doctor(fio: Fio(name: "Андрей", surname: "Андреев", patronymic: "Андреевич"), queue: 5, price: 2000, position: "Педиатр"),
        "Терапевт": Doctor(fio: Fio(name: "Борис", surname: "Борисов", patronymic: nil), queue: 13, price: 5000, position: "Терапевт"),
        "Окулист": Doctor(fio: Fio(name: "Василий", surname: "Васильев", patronymic: "Васильевич"), queue: 0, price: 6000, position: "Окулист"),
        "Кардиолог": Doctor(fio: Fio(name: "Григорий", surname: "Григорьев", patronymic: "Григорьевич"), queue: 9, price: 5500, position: "Кардиолог"),
        "ЛОР": Doctor(fio: Fio(name: "Даниил", surname: "Данилов", patronymic: nil), queue: 16, price: 4000, position: "ЛОР"),
        "Хирург": Doctor(fio: Fio(name: "Евгений", surname: "Евгеньев", patronymic: "Евгеньевич"), queue: 3, price: 9000, position: "Хирург"),
        "Невролог": Doctor(fio: Fio(name: "Пётр", surname: "Петров", patronymic: "Петрович"), queue: 7, price: 3200, position: "Невролог")]
    
    func getAppointment(doctorPosition name: String, fundsAvailable funds: inout Int) -> (Doctor?, AppointmentError?) {
        guard let position = list[name] else {
            return (nil, AppointmentError.invalidSelection)
        }
        
        guard position.queue <= 10 else {
            return (nil, AppointmentError.longQueue)
        }
        
        guard position.price <= funds else {
            return (nil, AppointmentError.insufficientFunds(fundsNeeded: position.price - funds))
        }
        
        funds -= position.price
        return (position, nil)
    }
    
    func addDoctor(doctorFio fio:Fio, doctorPrice price:Int, doctorPosition name: String) throws {
        if let _ = list[name] {
            throw ChangeError.alreadyExists
        } else if price > 10000 {
            throw ChangeError.priceTooHigh
        }
        
        let doctor = Doctor(fio: fio, queue: 0, price: price, position: name)
        list[name] = doctor
        
        print("Доктор успешно добавлен в список клиники")
    }
    
    func changePrice(doctorPosition name: String, _ newPrice: Int) throws {
        guard let position = list[name] else {
            throw AppointmentError.invalidSelection
        }
        
        guard newPrice <= 10000 else {
            throw ChangeError.priceTooHigh
        }
        
        var newDoctor = position
        newDoctor.price = newPrice
        list[name] = newDoctor
        
        print("Цена за приём успешно изменена")
    }
}

let clinic = Clinic()
var fundsAvailable = 16000

let appointment1 = clinic.getAppointment(doctorPosition: "Хирург", fundsAvailable: &fundsAvailable)
print("Appointment1 (Хирург)")
if let doctor = appointment1.0 {
    print("Вы успешно записались на приём, ваш врач: \(doctor.position) \(doctor.fio.surname) \(doctor.fio.name) \(doctor.fio.patronymic ?? "")")
} else if let error = appointment1.1 {
    print("Произошла ошибка: \(error.descriprion)")
}

let appointment2 = clinic.getAppointment(doctorPosition: "Психиатр", fundsAvailable: &fundsAvailable)
print("\nAppointment2 (Психиатр)")
if let doctor = appointment2.0 {
    print("Вы успешно записались на приём, ваш врач: \(doctor.position) \(doctor.fio.surname) \(doctor.fio.name) \(doctor.fio.patronymic ?? "")")
} else if let error = appointment2.1 {
    print("Произошла ошибка: \(error.descriprion)")
}

let appointment3 = clinic.getAppointment(doctorPosition: "ЛОР", fundsAvailable: &fundsAvailable)
print("\nAppointment3 (ЛОР)")
if let doctor = appointment3.0 {
    print("Вы успешно записались на приём, ваш врач: \(doctor.position) \(doctor.fio.surname) \(doctor.fio.name) \(doctor.fio.patronymic ?? "")")
} else if let error = appointment3.1 {
    print("Произошла ошибка: \(error.descriprion)")
}

let appointment4 = clinic.getAppointment(doctorPosition: "Хирург", fundsAvailable: &fundsAvailable)
print("\nAppointment4 (Хирург)")
if let doctor = appointment4.0 {
    print("Вы успешно записались на приём, ваш врач: \(doctor.position) \(doctor.fio.surname) \(doctor.fio.name) \(doctor.fio.patronymic ?? "")")
} else if let error = appointment4.1 {
    print("Произошла ошибка: \(error.descriprion)")
}

do {
    print("\nAdd doctor (Психиатр)")
    try clinic.addDoctor(doctorFio: Fio(name: "Павел", surname: "Павлов", patronymic: "Павлович"), doctorPrice: 30000, doctorPosition: "Психиатр")
} catch ChangeError.alreadyExists {
    print("Доктор на такой должности уже есть в клинике")
} catch ChangeError.priceTooHigh {
    print("Цена за прием не может быть выше 10000 рублей")
} catch let error {
    print(error.localizedDescription)
}

do {
    print("\nAdd doctor (Психиатр)")
    try clinic.addDoctor(doctorFio: Fio(name: "Павел", surname: "Павлов", patronymic: "Павлович"), doctorPrice: 3000, doctorPosition: "Психиатр")
} catch ChangeError.alreadyExists {
    print("Доктор на такой должности уже есть в клинике")
} catch ChangeError.priceTooHigh {
    print("Цена за прием не может быть выше 10000 рублей")
} catch let error {
    print(error.localizedDescription)
}

do {
    print("\nChange price (Окулист)")
    try clinic.changePrice(doctorPosition: "Окулист", 16000)
} catch ChangeError.alreadyExists {
    print("Доктор на такой должности уже есть в клинике")
} catch ChangeError.priceTooHigh {
    print("Цена за прием не может быть выше 10000 рублей")
} catch let error {
    print(error.localizedDescription)
}

do {
    print("\nChange price (Окулист)")
    try clinic.changePrice(doctorPosition: "Окулист", 8000)
} catch ChangeError.alreadyExists {
    print("Доктор на такой должности уже есть в клинике")
} catch ChangeError.priceTooHigh {
    print("Цена за прием не может быть выше 10000 рублей")
} catch let error {
    print(error.localizedDescription)
}

let appointment5 = clinic.getAppointment(doctorPosition: "Психиатр", fundsAvailable: &fundsAvailable)
print("\nAppointment5 (Психиатр)")
if let doctor = appointment5.0 {
    print("Вы успешно записались на приём, ваш врач: \(doctor.position) \(doctor.fio.surname) \(doctor.fio.name) \(doctor.fio.patronymic ?? "")")
} else if let error = appointment5.1 {
    print("Произошла ошибка: \(error.descriprion)")
}
