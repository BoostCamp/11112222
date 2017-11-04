//
//  CheckMarkView.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 23..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CheckMarkView: UIImageView,Scalable{
    
    func commonSetup(){
        alpha = 0
        image = UIImage(named: "check-mark")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonSetup()
    }
    
}
