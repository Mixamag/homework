//
//  Model.swift
//  ToDoList
//
//  Created by Mikhail Gorbunov on 18.05.2024.
//

// методы работы с данными, изъятие данных на обработку
import Foundation
import UIKit

// описание объекта, передающего модель
class Item {
    //задача
    var string: String

    
    init(string: String, completed: Bool) {
        self.string = string

    }
}
// класс модели
class Model {

    // массив items
    var toDoItems: [Item] = [
                            Item(string: "Do something", completed: false),
                            Item(string: "Task1", completed: true),
                            Item(string: "Create app", completed: false),
                            Item(string: "Create app", completed: false),
                            Item(string: "Create app", completed: false)
                            ]
    //изменить контент ячейки
    func updateItem(at index: Int, with string: String) {
        toDoItems[index].string = string
    }
    
    //удалить item по индексу
    func removeItem(at index: Int) {
        toDoItems.remove(at: index)
    }
    
}
