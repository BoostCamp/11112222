//
//  HomeViewContoller+Category.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 21..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize!
        let tempLabel = UILabel()
        let labelText = categories[indexPath.row].name
        
        tempLabel.text = labelText
        tempLabel.font = UIFont(name: "Avenir Next Condensed", size: 15)
        tempLabel.sizeToFit()
        tempLabel.isHidden = true
        
        
        size = CGSize(width: tempLabel.intrinsicContentSize.width + 56, height: 56)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        let category = CategoryGenerator.sharedInstance().homeCategories[indexPath.row]
        
        cell.updateUI(category: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let categoryCell = cell as! CategoryCollectionViewCell
        categoryCell.configureCell(selected: cell.isSelected)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath)
        if (cell?.isSelected)! { // 눌린 상태이면 또 눌리면 안돼
            return false
        } else {
            return true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        selectedCell.configureCell(selected: true)
        
        
        let category = categories[indexPath.row]
        fetchCardsData(with: category)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            let selectedCell = cell as! CategoryCollectionViewCell
            selectedCell.configureCell(selected: false)
        }
    }

}
