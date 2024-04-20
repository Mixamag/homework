//
//  ShowImageVC.swift
//  CollectionView
//
//  Created by Mikhail Gorbunov on 20.04.2024.
//

import UIKit

class ShowImageVC: UIViewController {

    @IBOutlet weak var currentImage: UIImageView!
    var imageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentImage.image = UIImage(named: imageName)
    }
    
    func setImageName(name: String) {
        imageName = name
    }

}
