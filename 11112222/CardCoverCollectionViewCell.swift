//
//  CardCoverCollectionViewCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 13..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit
import Nuke

class CardCoverCollectionViewCell: CardItemCell {
    //MARK: - IBOutlet
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postedAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(card: Card) {
        if let mainColor = card.mainColor {
            backgroundColor = UIColor.init(netHex: mainColor)
        } else {
            backgroundColor = UIColor.getRandomColor()
        }
        usernameLabel.text = card.username
        
        if let photoURL = card.photoURL {
            if let url = URL(string:photoURL){
                Nuke.loadImage(with: url, into: profileImageView)
            }
        }
        titleLabel.text = card.title
        let desiredLabelWidth = self.contentView.bounds.size.width - 20
        let size = titleLabel.sizeThatFits(CGSize(width: desiredLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        titleLabel.frame = CGRect(x: 10, y: 10, width: desiredLabelWidth, height: size.height)
        
        if let desc = card.desc {
            descLabel.text = desc
            let descSize = descLabel.sizeThatFits(CGSize(width: desiredLabelWidth, height: CGFloat.greatestFiniteMagnitude))
            descLabel.frame = CGRect(x: 10, y: size.height+10, width: desiredLabelWidth, height: descSize.height)
        } else {
            descLabel.isHidden = true
        }
        
        if card.untilAt.0 {
            
        }
        
        postedAtLabel.text = card.untilAt.1
        
        if card.isVoted {
            goResultButton.isHidden = false
        } else {
            goResultButton.isHidden = true
        }
        
    }
    
    
}
