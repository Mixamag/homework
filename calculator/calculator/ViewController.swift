//
//  ViewController.swift
//  calculator
//
//  Created by Mikhail Gorbunov on 28.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelResult: UILabel!
    
    var numberScreen: Double = 0  //вторая переменная
    var firstNum: Double = 0    // первая переменная
    var operation: Int = 0
    var mathSign: Bool = false   // математический знак стоит?
    var dotIsPlased = false

    
    @IBAction func pressNum(_ sender: UIButton) {
        if mathSign == true {
            labelResult.text = String(sender.tag)
            mathSign = false
        }else {
            labelResult.text = labelResult.text! + String(sender.tag)
        }
        
        numberScreen = Double(labelResult.text!)!

    }
    
    
    @IBAction func dotButton(_ sender: UIButton) {
        if !dotIsPlased {
                    labelResult.text = labelResult.text! + "."
                    dotIsPlased = true
                    
        }else if !dotIsPlased {
                    labelResult.text = "0."
                }
        
        
        
    }
    
    
    
    @IBAction func buttons(_ sender: UIButton) {
        if labelResult.text != "" && sender.tag != 10 && sender.tag != 18 {
            firstNum = Double(labelResult.text!)!

            if sender.tag == 11 {    // 1/х
                labelResult.text = "1/x"
            }else if sender.tag == 12 {   // %
                labelResult.text = "%";
                
            }else if sender.tag == 13 {   // /
                labelResult.text = "÷";
                
            }else if sender.tag == 14 { // x
                labelResult.text = "x";
                
            }else if sender.tag == 15 { // -
                labelResult.text = "-";
                
            }else if sender.tag == 16 { // +
                labelResult.text = "+";
            }else if sender.tag == 17 { // ⎷
                labelResult.text = "⎷";
            }
            
            operation = sender.tag
            mathSign = true
            dotIsPlased = false
        }else if sender.tag == 18 {      // =
            if operation == 13 {
                labelResult.text = String(firstNum / numberScreen)
            }else if operation == 14 {
                labelResult.text = String(firstNum * numberScreen)
            }else if operation == 15 {
                labelResult.text = String(firstNum - numberScreen)
            }else if operation == 16 {
                labelResult.text = String(firstNum + numberScreen)
            }else if operation == 17 {
                labelResult.text = String(sqrt(firstNum))
            }else if operation == 12 {
                labelResult.text = String(firstNum / 100 * numberScreen)
            }else if operation == 11 {
                labelResult.text = String(1 / firstNum)
            }
            
        }else if sender.tag == 10 {
            labelResult.text = ""
            firstNum = 0
            numberScreen = 0
            operation = 0
            dotIsPlased = false
        }
        
    }
    
    
    
    
    
}
