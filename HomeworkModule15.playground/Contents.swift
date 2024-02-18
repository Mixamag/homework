import Cocoa

// MARK: - Создайте перечисление для ошибок. Добавьте в него 3 кейса

enum AutoError: Error {
    case notFound404
    case badRequest400
    case InternetServerError500
}

var notFound404: Bool = false
var badRequest400: Bool = false
var InternetServerError500: Bool = false


notFound404 = false
badRequest400 = false
InternetServerError500 = true


// MARK: - Далее создайте переменную, которая будет хранить в себе какую-либо ошибку (400 или 404 или 500). И при помощи do-catch сделайте обработку ошибок перечисления. Для каждой ошибки должно быть выведено сообщение в консоль.

do {
    if notFound404 {
        throw AutoError.notFound404
    }
    if badRequest400 {
        throw AutoError.badRequest400
    }
    if InternetServerError500 {
        throw AutoError.InternetServerError500
    }
    
} catch AutoError.notFound404 {
    print("ERROR 404. Not Found")
} catch AutoError.badRequest400 {
    print("ERROR 400. Bad Request")
} catch AutoError.InternetServerError500 {
    print("ERROR 500. Internet Server Error")
}

// MARK: - Теперь добавьте проверку переменных в генерирующую функцию и обрабатывайте её!



func GeneralFunc() throws {
    if notFound404 {
        throw AutoError.notFound404
    }
 
    if badRequest400 {
        throw AutoError.badRequest400
    }
 
    if InternetServerError500 {
        throw AutoError.InternetServerError500
    }
}

do {
    try GeneralFunc()
} catch AutoError.notFound404 {
    print("ERROR 404. Not Found")
} catch AutoError.badRequest400 {
    print("ERROR 400. Bad Request")
} catch AutoError.InternetServerError500 {
    print("ERROR 500. Internet Server Error")
}

// MARK: - Напишите функцию, которая будет принимать на вход два разных типа и проверять: если типы входных значений одинаковые, то вывести сообщение “Yes”, в противном случае — “No”.

func someFunc <T, E>(a: T, b: E) -> Void {
    if T.self == E.self {
        print ("Yes")
    }else {
        print ("No")
    }
}

// MARK: - ВВОД ВХОДНЫХ ЗНАЧЕНИЙ
someFunc(a: "x", b: 5.2)

// MARK: -




// MARK: - Реализуйте то же самое, но если тип входных значений различается, выбросите исключение. Если тип одинаковый — тоже выбросите исключение, но оно уже будет говорить о том, что типы одинаковые. Не бойтесь этого. Ошибки — это не всегда про плохой результат.

enum ErrorTypes: Error {
    case sameTypes
    case differentTypes
}
var sameTypes = false

func compareTypes <T, E>(a: T, b: E) -> Void {
    if T.self == E.self {
        sameTypes = false
    }else {
        sameTypes = true
    }
}

// MARK: - ВВОД ВХОДНЫХ ЗНАЧЕНИЙ
compareTypes(a: "π", b: 3.14)

// MARK: -


do {
    if sameTypes == true {
        throw ErrorTypes.sameTypes
    }
    if sameTypes == false {
        throw ErrorTypes.differentTypes
    }
    
} catch ErrorTypes.sameTypes {
    print("Введены разные типы входных значений")
} catch ErrorTypes.differentTypes {
    print("Тип входных значений идентичен")
}


// MARK: -  Напишите функцию, которая принимает на вход два любых значения и сравнивает их при помощи оператора равенства ==.

// Структура со свойствами
struct people {
    var sex = String()
    var age = Int ()
    var weight = Double ()
}

// расширение для сравнения структуры

extension people: Equatable {
    static func == (lhs: people, rhs: people) -> Bool {
        return lhs.sex == rhs.sex &&
        lhs.age == rhs.age &&
        lhs.weight == rhs.weight
    }
}

// элементы структуры со свойствами для сравнения

let man1 = people(sex: "man", age: 13, weight: 45.4)
let man2 = people(sex: "woman", age: 25, weight: 55.5)

// сравнение

if man1 == man2 {
    print ("Люди схожи по полу, возрасту и весу")
}else {
    print ("Люди не схожи")
}
