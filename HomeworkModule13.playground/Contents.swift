//MARK: - 
//Создай кортеж для двух человек с одинаковыми типами данных и параметрами.
//При том одни значения доставай по индексу, а другие — по параметру.

let man1 = (age: 70, name: "Rick", sex: "man")
let man2 = (age: 34, name: "Beth", sex: "woman")
man1.0
man2.sex

//MARK: - Создай массив «дни в месяцах» (12 элементов содержащих количество дней в соответствующем месяце). Используя цикл for и этот массив:

// выведи количество дней в каждом месяце
let daysMonths1: [Int] = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
for (index, value) in daysMonths1.enumerated() {
    print("\(index + 1): \(value)")
}
// используй еще один массив с именами месяцев чтобы вывести название месяца + количество дней
let month1: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
                ]
for (index, value) in month1.enumerated() {
    print("\(index + 1): \(value) = \(daysMonths1[index + 0])")
}

// сделай тоже самое, но используя массив кортежей с параметрами (имя месяца, количество дней)
let months2 = [(month: "January", days: 31),
               (month: "February", days: 29),
               (month: "March", days: 31),
               (month: "April", days: 30),
               (month: "May", days: 31),
               (month: "June", days: 30),
               (month: "July", days: 31),
               (month: "August", days: 31),
               (month: "September", days: 30),
               (month: "October", days: 31),
               (month: "November", days: 30),
               (month: "December", days: 31),
]
/// c нумерацией
for (index, value) in months2.enumerated() {
    print("\(index + 1): \(value)")
}
/// без нумерации
for month in 0...11 {
    print ("In \(months2[month].0) \(months2[month].1) days")
}

// сделай тоже самое, только выведи дни в обратном порядке (порядок в исходном массиве не меняется)
for month in 0...11 {
    print ("\(months2[month].1) days in \(months2[month].0)")
}

//MARK: - для произвольно выбранной даты (месяц и день) посчитай количество дней до конца года

// ввести день
var anyDay = 31
// ввести месяц
var anyMonth = 12

// расчет
var realMonth = anyMonth - 1
var daysPassed = 0
for month3 in 0 ..< months2.count {
    if(month3 == realMonth){
        break
    }
    if(month3 == 0) {
        daysPassed += months2[month3].1
    }else{
        daysPassed += months2[month3].1
    }
}
daysPassed += anyDay
print("\(daysPassed) days has passed")


// MARK: -   Создай словарь, как журнал студентов, где имя и фамилия студента это ключ, а оценка за экзамен — значение.

var students: [String: Int] = ["JohnSnow": 5,
                              "AlexMorgan": 4,
                              "BartSimpson": 3,
                              "MortySmith": 2,
                               "CarlJohnson": 1
]

for (student, counts) in students {
    print(student, counts)
}

// Повысь студенту оценку за экзамен

students.updateValue(4, forKey: "MortySmith")

for (student, counts) in students {
    print(student, counts)
}


// Если оценка положительная (4 или 5) или удовлетворительная (3), то выведи сообщение с поздравлением, отрицательная (1, 2) - отправь на пересдачу

for (student, counts) in students {
    if counts >= 3 {
        print ("Поздравляем, \(student)")
    }else {
        print ("Пересдача, \(student)")
    }
}

// Добавь еще несколько студентов — это будут новые одногруппники!

students["GarryPotter"] = 3
students["SpanchBob"] = 5
students["JoshMoore"] = 5

for (student, counts) in students {
    print(student, counts)
}

// Удали одного студента — он отчислен
    students.removeValue(forKey: "CarlJohnson")

for (student, counts) in students {
    print(student, counts)
}

// Посчитай средний балл всей группы по итогам экзамена.

let countsStudents = students.count
let sumCounts = students.values.reduce(0, +)
print ("Средний балл группы равен \(Float(sumCounts)/Float(countsStudents))")
