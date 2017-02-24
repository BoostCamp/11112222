//
//  CardItemCollectionViewCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 8..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit
import Nuke

class CardItemCollectionViewCell: CardItemCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var optionImageView: UIImageView!
    func configureCell(item: VoteItem){
        optionImageView.image = nil
        if let imageUrl = item.imageUrl {
            if let url = URL.init(string: imageUrl){
                Nuke.loadImage(with: url, into: optionImageView)
            }
        }
        checkIfUserVotedAndShowCheckMark(vote: item)
    }
    
}
