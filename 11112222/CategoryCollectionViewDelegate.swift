//
//  CategoryCollectionViewDelegate.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 9..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation
import UIKit
class CategoryCollectionViewDelegate : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let dataController: DataController = DataController.sharedInstance()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize!
        let tempLabel = UILabel()
        let labelText = dataController.getCategoryDummyData()[indexPath.row].name
        
        tempLabel.text = labelText
        tempLabel.font = UIFont(name: "Avenir Next Condensed", size: 15)
        tempLabel.sizeToFit()
        tempLabel.isHidden = true
        
        
        size = CGSize(width: tempLabel.intrinsicContentSize.width + 56, height: 56)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataController.getCategoryDummyData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.titleLabel.text = dataController.getCategoryDummyData()[indexPath.row].name
        
        
        cell.updateUI()
        return cell
    }
    
}
