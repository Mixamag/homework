//
//  CustomCell.swift
//  ToDoList
//
//  Created by Mikhail Gorbunov on 20.05.2024.
//

import UIKit

protocol CustomCellDelegate {
    func editCell(cell: CustomCell)
    func deleteCell(cell: CustomCell)
}

class CustomCell: UITableViewCell {
    
    var cellStart: UITableViewCell = {
        let start = UITableViewCell()
        
        return start
    }()
    
    var delegate: CustomCellDelegate?
    
    @IBOutlet weak var LabelCell: UILabel!
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var EditButton: UIButton!
    
    
    @IBAction func DeleteButtonAction(_ sender: UIButton) {
        delegate?.deleteCell(cell: self)
    }
    
    @IBAction func EditButtonAction(_ sender: UIButton) {
        delegate?.editCell(cell: self)
    }
    

}
