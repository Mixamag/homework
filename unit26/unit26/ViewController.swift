//
//  ViewController.swift
//  unit26
//
//  Created by Mikhail Gorbunov on 24.05.2024.
//

import UIKit

class ViewController: UIViewController {
    let defaultSettings = UserDefaults.standard
    let switcherSettingKey = "switcherSetting"
   
   
    lazy var switchSelector: UISwitch = {
        let switchWidht = 100
        let switchHeight = 50
        let switchX = Int(view.bounds.size.width / 2) - (switchWidht / 2)
        let switchY = Int(view.bounds.size.height) - switchHeight - 50
        return createSwitch(x: switchX, y: switchY, width: switchWidht, height: switchHeight)
                            }()
    
    lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 10, y: 50, width: 375, height: 700)
            return imageView
        }()
        
       
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "light")
        view.addSubview(imageView)
        view.addSubview(switchSelector)
        
        switchSelector = UISwitch()
        switchSelector.isOn = loadSwitcherSetting()
        setSwitch(switchSelector)
    }
   
    
    
    func saveSwitcherSetting(isEnabled: Bool) {
        defaultSettings.set(isEnabled, forKey: switcherSettingKey)
       }

    func loadSwitcherSetting() -> Bool {
        return defaultSettings.bool(forKey: switcherSettingKey)
    }
  
    
    
    func createImage(name: String, x: Int, y: Int, width: Int, height: Int) -> UIImageView {
        let imageView = UIImageView()
        guard let image: UIImage = UIImage(named: name) else { return  UIImageView()}
        imageView.image = image
        imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        return imageView
    }
    
    func createSwitch( x: Int, y: Int, width: Int,  height: Int) -> UISwitch {
        let switchPanel: UISwitch = UISwitch()
        switchPanel.frame = CGRect(x: x, y: y, width: width, height: height)
        switchPanel.addTarget(self,
                           action: #selector(setSwitch),
                           for: .valueChanged)
        return switchPanel
    }
    
    @objc func setSwitch(_ sender: UISwitch) {
        saveSwitcherSetting(isEnabled: sender.isOn)
        
        switch sender.isOn {
        case true:
            setBackground(namedImage: "dark", color: .black)
        case false:
            setBackground(namedImage: "light", color: .lightGray)
         }
    }
    
    func setBackground(namedImage: String, color: UIColor) {
        view.backgroundColor = color
        imageView.image = UIImage(named: namedImage)
    }
 
}

