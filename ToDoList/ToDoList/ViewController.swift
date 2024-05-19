//
//  ViewController.swift
//  ToDoList
//
//  Created by Mikhail Gorbunov on 17.05.2024.
//

// инициализатор таблицы

import UIKit

class ViewController: UIViewController {
    let model = Model()
    var alert = UIAlertController()
    // инициализация tableView
    lazy var tableView: UITableView = {
        let table = UITableView()
        // убрать constaints у autoresizingMask
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        // вставить свою ячейку
        table.register(CustomCell.self, forCellReuseIdentifier: "CustomCellView")

        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // цвет view
        view.backgroundColor = .white
        // добавить таблицу во view
        view.addSubview(tableView)
        //constraints tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        
        self.definesPresentationContext = true
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        
        
        tableView.separatorColor = .gray
        
        
        tableView.reloadData()
        
    }
    // MARK: -
    //изменить контент ячейки
    func editCellContent(indexPath: IndexPath) {

        let cell = tableView(tableView, cellForRowAt: indexPath) as! CustomCell
        
        alert = UIAlertController(title: "Edit your task", message: nil, preferredStyle: .alert)

        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
            textField.text = cell.LabelCell.text
            
        })
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let editAlertAction = UIAlertAction(title: "Submit", style: .default) { (createAlert) in
            
            guard let textFields = self.alert.textFields, textFields.count > 0 else{
                return
            }
            
            guard let textValue = self.alert.textFields?[0].text else {
                return
            }
            
            self.model.updateItem(at: indexPath.row, with: textValue)
            
            self.tableView.reloadData()

        }
        // удалить ячейку
        func deleteCell(cell: CustomCell) {
            
            let indexPath = tableView.indexPath(for: cell)
            
            guard let unwrIndexPath = indexPath else {
                return
            }
            
            model.removeItem(at: unwrIndexPath.row)
            tableView.reloadData()
        }
        
        alert.addAction(cancelAlertAction)
        alert.addAction(editAlertAction)
        present(alert, animated: true, completion: nil)
        
    }

    
    @objc func alertTextFieldDidChange(_ sender: UITextField) {

            guard let senderText = sender.text, alert.actions.indices.contains(1) else {
                return
            }

            let action = alert.actions[1]
            action.isEnabled = senderText.count > 0
        }
    

//MARK: -
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //вернуть ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellView", for: indexPath)
        
        let cellModel = model.toDoItems[indexPath.row]
        var listConfiguration = cell.defaultContentConfiguration()
        listConfiguration.text = cellModel.string
        
        cell.contentConfiguration = listConfiguration
        
        return cell
    }
    
    //количество объектов в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.toDoItems.count
    }
}
