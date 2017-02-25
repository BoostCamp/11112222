//
//  DeadLinePickerCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 21..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

protocol DeadLinePickerCellDelegate {
    func pickerValueChanged(date: Date)
}
class DeadLinePickerCell: UITableViewCell {
    var delegate : DeadLinePickerCellDelegate?

    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBAction func dpValueChanged(_ sender: Any) {
        delegate?.pickerValueChanged(date: datePickerView.date)
    }
    
    func configureCell(){
        datePickerView.minimumDate = Date()
        datePickerView.maximumDate = Date(timeIntervalSinceNow: 60*60*24*7) // 일주일 후
    }
    
}
