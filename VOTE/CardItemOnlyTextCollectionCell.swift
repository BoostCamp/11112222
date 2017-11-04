//
//  CardItemOnlyTextCollectionCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 21..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CardItemOnlyTextCollectionCell: CardItemCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(item: VoteItem) {
        descriptionLabel.text = item.text
        let desiredLabelWidth = self.contentView.bounds.size.width - 20
        let size = descriptionLabel.sizeThatFits(CGSize(width: desiredLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        descriptionLabel.frame = CGRect(x: 10, y: 10, width: desiredLabelWidth, height: size.height)
        
        checkIfUserVotedAndShowCheckMark(vote: item)
        goResultButton.isHidden = true
    }
}
