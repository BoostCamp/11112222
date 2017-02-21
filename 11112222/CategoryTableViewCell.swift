//
//  CategoryTableViewCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 15..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    //MAKR: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(category: Category) {
        titleLabel.text = category.name
        iconImageView.image = UIImage.init(named: "pokemon.png")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
