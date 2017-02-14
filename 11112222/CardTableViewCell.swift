//
//  CardTableViewCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 8..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return DataController.sharedInstance().getCardDummyData()[index].voteItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // configureCell
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCoverCollectionCell", for: indexPath) as! CardCoverCollectionViewCell
            
            cell.configureCell(card: DataController.sharedInstance().getCardDummyData()[index])
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardItemCollectionCell", for: indexPath) as! CardItemCollectionViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 375
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.collectionView.collectionViewLayout as! CenterCellCollectionViewFlowLayout
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        let roundedIndex = round(index)
//        
//        offset = CGPoint.init(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//        
//    }

    
}




//extension CardTableViewCell {
//    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
//        collectionView.dataSource = dataSourceDelegate
//        collectionView.delegate = dataSourceDelegate
//        collectionView.tag = row
//        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
//        collectionView.reloadData()
//    }
//    
//    func setupFlowLayout() {
//        collectionView.contentOffset.x = 0
//        flowLayout.itemSize = CGSize(width: self.frame.width, height: self.frame.width)
//    }
//}
