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
    func titleEndEditting(text : String)
}

class EditCardTableHeaderCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var deadlineView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var delegate : EditCardHeaderViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(){
        titleTextField.delegate = self

        emptyView.isUserInteractionEnabled = true
        descLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(emptyViewTapped)))
        emptyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(emptyViewTapped)))
        
        categoryButton.setTitleColor(UIColor.gray, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc private func emptyViewTapped() {
        print("1434235425")
        delegate?.emptyViewTapped(cell: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.titleEndEditting(text: textField.text!)
    }
}
