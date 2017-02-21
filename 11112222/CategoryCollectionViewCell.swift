//
//  CategoryCollectionViewCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 9..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var backgroundCategoryView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(category: Category) {
        titleLabel.text = category.name
        backgroundCategoryView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        backgroundCategoryView.layer.cornerRadius = 3.0
        backgroundCategoryView.layer.masksToBounds = false
        backgroundCategoryView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        
        backgroundCategoryView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        
        backgroundCategoryView.layer.shadowOpacity = 0.8
    }
    
    
    func configureCell(selected: Bool){
        if selected {
            backgroundCategoryView.backgroundColor = UIColor.FlatColor.Green.Fern
        } else {
            backgroundCategoryView.backgroundColor = UIColor.white

        }
    }

}
