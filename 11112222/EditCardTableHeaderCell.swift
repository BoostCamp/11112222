//
//  EditCardTableHeaderCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 10..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

protocol EditCardHeaderViewDelegate {
    func emptyViewTapped(cell : EditCardTableHeaderCell)
}

class EditCardTableHeaderCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    var delegate : EditCardHeaderViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(){
        titleTextField.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(emptyViewTapped))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(emptyViewTapped))
        emptyView.isUserInteractionEnabled = true
        descLabel.addGestureRecognizer(tapGestureRecognizer2)
        emptyView.addGestureRecognizer(tapGestureRecognizer)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func emptyViewTapped() {
        delegate?.emptyViewTapped(cell: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
