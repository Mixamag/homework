//
//  ViewController.swift
//  CollectionView
//
//  Created by Mikhail Gorbunov on 20.04.2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    @IBOutlet weak var collectionViewOne: UICollectionView!
    @IBOutlet weak var collectionViewTwo: UICollectionView!
    let arrayTemperature = ["temp.green",
                            "temp.blackGreen",
                            "temp.lightYellow",
                            "temp.darkYellow",
                            "temp.orange",
                            "temp.red"]
    let arraySmile = ["nice",
                      "favorite",
                      "routine",
                      "notPleasant",
                      "bad",
                      "hate"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewOne.delegate = self
        collectionViewOne.dataSource = self
        collectionViewTwo.delegate = self
        collectionViewTwo.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ShowImageVC") as? ShowImageVC else { return }
        var currentSelectedImage: String!
        //currentSelectedImage = arrayTemperature[indexPath.row]
        if collectionView == collectionViewOne{
              currentSelectedImage = arrayTemperature[indexPath.row]
            }
         
        if collectionView == collectionViewTwo{
              currentSelectedImage = arraySmile[indexPath.row]
            }
        
        vc.setImageName(name: currentSelectedImage)
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return arrayTemperature.count
        if collectionView == collectionViewOne {
              return arrayTemperature.count
            }
            if collectionView == collectionViewTwo {
              return arraySmile.count
            }
            return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOne", for: IndexPath()) as? Cell {
//            let imageName = arrayTemperature[indexPath.row]
//            cell.setTemperatureImage(tempName: imageName)
//            return cell
        if collectionView == collectionViewOne{
              if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOne", for: indexPath) as? Cell {
                let imageName = arrayTemperature[indexPath.row]
                cell.setTemperatureImage(tempName: imageName)
                return cell
              }
            }
            if collectionView == collectionViewTwo{
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTwo", for: indexPath) as? Cell {
                    let imageName = arraySmile[indexPath.row]
                    cell.setSmileImage(smileName: imageName)
                    return cell
                }
        }
        return UICollectionViewCell()
    }
}

