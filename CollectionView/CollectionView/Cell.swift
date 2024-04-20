//
//  Cell.swift
//  CollectionView
//
//  Created by Mikhail Gorbunov on 20.04.2024.
//

import UIKit

class Cell: UICollectionViewCell {
    
    @IBOutlet weak var temperatureImage: UIImageView!
    @IBOutlet weak var smileImage: UIImageView!
    
    func setTemperatureImage(tempName: String) {
        temperatureImage.image = UIImage(named: tempName)
    }
    func setSmileImage(smileName: String) {
        smileImage.image = UIImage(named: smileName)
    }

}


