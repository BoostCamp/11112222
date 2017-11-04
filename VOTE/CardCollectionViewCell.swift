//
//  CardCollectionViewCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 24..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardCoverImageView: UIImageView!
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var closedLabel: UILabel!
    
    func configureCell(card: Card) {
        if let mainColor = card.mainColor {
            cardCoverImageView.backgroundColor = UIColor(netHex: mainColor)
        }
        if let title = card.title {
            cardTitleLabel.text = title
        }
        if let username = card.username {
            usernameLabel.text = username
        }
        closedLabel.text = card.untilAt.1
        if !card.untilAt.0 {
            closedLabel.textColor = UIColor.FlatColor.AppColor.ChiliPepper
        } else {
            closedLabel.textColor = UIColor.white
        }
    }
}
