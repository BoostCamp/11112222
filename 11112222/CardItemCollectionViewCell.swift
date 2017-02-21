//
//  CardItemCollectionViewCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 8..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CardItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var optionImageView: UIImageView!
    
    func configureCell(item: VoteItem) -> Void {
        if let image = item.image {
            optionImageView.image = image
        }
    }
}
