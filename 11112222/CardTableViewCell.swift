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
    
    var card : Card!
    var index : Int!
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
    
    func configureCell(card: Card) {
        self.card = card
        collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return card.voteItems.count + 1 // covercount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCoverCollectionCell", for: indexPath) as! CardCoverCollectionViewCell
            
            cell.card = card
            cell.configureCell(card: self.card)
            return cell
        }
        
        let voteItem = self.card.voteItems[indexPath.row-1]
        
        if voteItem.type == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardItemOnlyTextCollectionCell", for: indexPath) as! CardItemOnlyTextCollectionCell
            cell.backgroundColor = UIColor.FlatColor.CardColor.SmokeWhite
            cell.card = card
            cell.configureCell(item: voteItem)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardItemCollectionCell", for: indexPath) as! CardItemCollectionViewCell
            cell.card = card
            cell.configureCell(item: voteItem)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("투표상태 \(card.isVoted)")
        if indexPath.row > 0 && !card.isVoted {
            let voteIndex = indexPath.row - 1 // 커버 빼주기
            let voteItem = self.card.voteItems[voteIndex]
            let dataContoller = DataController.sharedInstance()
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CardItemCell{
                dataContoller.vote(to: voteItem, self.card) { (committed) in
                    if committed {
                        cell.card = dataContoller.successVoteToCard(at: self.index, selectedVote: voteItem)
                        print(dataContoller.successVoteToCard(at: self.index, selectedVote: voteItem).voteCount!)
                        print("card count \(cell.card?.voteCount!)")
                        print("card votes \(cell.card?.votes)")
                        self.collectionView.reloadItems(at: [IndexPath(row:0,section:0)])
                        cell.showCheckMarkAndResultButtonWithAnimation()
                        
                    }
                }
                
                
            }
            
        }
    }

    
}
