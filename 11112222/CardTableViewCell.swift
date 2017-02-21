//
//  CardTableViewCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 8..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var showVoteResultButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel : UILabel!
    var index : Int = 0
    var card : Card!
    
    var indexPath :IndexPath =  IndexPath(row: 0, section: 0)
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
//        self.card = card
//        if card.isClosed {
//            showVoteResultButton.setTitle("종료된 투표", for: .normal)
//            showVoteResultButton.backgroundColor = UIColor.FlatColor.Red.TerraCotta
//
//        } else if !card.isClosed && ( (card.user?.isOwner!)! || card.isVote! ) {
//            showVoteResultButton.setTitle("투표 진행 보러가기", for: .normal)
//            showVoteResultButton.backgroundColor = UIColor.FlatColor.Green.ChateauGreen
//            showVoteResultButton.isHidden = false
//
//            
//        } else {
//            showVoteResultButton.isHidden = true
//        }
        
        usernameLabel.text = card.user?.name
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 375
//    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        

        return card.voteItems.count + 1 // covercount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // configureCell
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCoverCollectionCell", for: indexPath) as! CardCoverCollectionViewCell
            
            cell.configureCell(card: self.card)
            
        
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardItemCollectionCell", for: indexPath) as! CardItemCollectionViewCell
        

        
//        cell.configureCell(item: DataController.sharedInstance().getCardDummyData()[index].voteItems[indexPath.row-1])
        
        
        
//        
//        cell.configureCell(DataController.sharedInstance().getCardDummyData()[index].voteItems[0])
        
        return cell
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        let centerPoint : CGPoint = CGPoint(x:self.collectionView.frame.size.width / 2 + scrollView.contentOffset.x, y:self.collectionView.frame.size.height/2 + scrollView.contentOffset.y)
//        
//        let indexPath : IndexPath = self.collectionView.indexPathForItem(at: centerPoint)!
//    
//        
//        
//        //if(indexPath != self.indexPath) {
//            self.indexPath = indexPath
//       /// }
//        
//        
//    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if cell != nil {

            //self.indexPath = IndexPath(row: indexPath.row, section: indexPath.section)
        
//        var aFrame = cell.bounds
//        aFrame.size.width = 315
//        aFrame.size.height = 315
//        cell.bounds = aFrame
        
//        if(indexPath.row != 0) {
//            self.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
//        }
//            self.collectionView.reloadItems(at: [indexPath])
//            self.collectionView.reloadData()
//        }
    }
    
    
    
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        var aFrame = cell.bounds
//        aFrame.size.width = 250
//        aFrame.size.height = 250
//        cell.bounds = aFrame
//    }
    
    // 게시물 화면에 꽉 차게 하기 - center에 오게 하기
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 30
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: collectionView.frame.size.width - 100, height: collectionView.frame.size.height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15);
//
//    }

    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        guard indexPath.row != 0 else { return }
        
        
        if !card.isClosed {
            card.isVote = true
            // 메소드로 빼자
            showVoteResultButton.backgroundColor = UIColor.FlatColor.Green.ChateauGreen
            showVoteResultButton.setTitle("투표 진행 보러가기", for: .normal)
            showVoteResultButton.isHidden = false
            

        } else {
            print("닫힌 투표")
        }
       
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
