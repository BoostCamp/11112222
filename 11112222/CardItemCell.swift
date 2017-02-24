//
//  CardItemCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 23..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CardItemCell: UICollectionViewCell{
    var card: Card?
    @IBOutlet weak var checkmarkView : CheckMarkView!
    @IBOutlet weak var goResultButton : UIButton!
    
    func goToResultViewController(_ sender: Any) {
        if let card = card {
            print("card count \(card.voteCount!)")
            print("card votes \(card.votes)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: CardNotification.Name), object: card)
        }
    }
    
    override func awakeFromNib() {
        goResultButton.addTarget(self, action: #selector(goToResultViewController(_:)), for: .touchUpInside)
    }
    
    func showCheckMark() {
        checkmarkView.scale()
    }
    
    func hideCheckMark() {
        checkmarkView.isHidden = true
    }
    
    func showGoResultButton(_ enabled: Bool){
        goResultButton.isHidden = enabled
    }
    
    func showCheckMarkAndResultButtonWithAnimation(){
        UIView.animate(withDuration: 1, delay: 2, animations: {
            self.checkmarkView.scale()
        }) { (true) in
            self.goResultButton.isHidden = false
            self.goResultButton.alpha = 1
        }
    }
    
    private func setCardValueWithVote(_ voted: Bool, index: Int) {
        if voted {
            //            if let card = self.card {
            //                card.isVoted = true
            //                let userID = UserDefaults.standard.value(forKey: "uid")
            //                if var voteCount = card.voteCount, var votes = card.votes {
            //                    voteCount = voteCount + 1
            //                    votes.updateValue(card.voteItems[index].id, forKey: userID!)
            //                } else {
            //                    let votes = [String:String]()
            //                    card.voteCount = 1
            //                    votes.updateValue(card.voteItems[index].id, forKey: userID!)
            //                    card.votes = votes
            //                }
            //
            //            }
            
            
        }
        
        
    }
    
    func checkIfUserVotedAndShowCheckMark(vote : VoteItem) {
        if let card = self.card {
            if let votes = card.votes {
                if let userID = LoginManager.sharedInstance().getUserID(){
                    if votes[userID] == vote.id! {
                        showCheckMark()
                    } else {
                        hideCheckMark()
                    }
                }
            }
        }
    }
    
}
