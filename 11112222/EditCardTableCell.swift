//
//  EditCardTableCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 10..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit
protocol EditCardItemViewDelegate {
    func pickImageClick(cell : EditCardTableCell)
    func didEndEditing(tag : Int, text: String, trimmed: String)
}

class EditCardTableCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var optionLabel: UITextField!
    var delegate : EditCardItemViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell() {
        optionLabel.delegate = self
    }
    
    @IBAction func cameraClick() {
        delegate?.pickImageClick(cell: self)
    }
    
    
    //MARK: - TextField Delegate
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        let input = textField.text!
        let trimmed = input.trimmingCharacters(in: .whitespaces)
        
        delegate?.didEndEditing(tag : self.tag, text: input, trimmed: trimmed)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
