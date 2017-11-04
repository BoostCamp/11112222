//
//  File.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 23..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation

protocol Scalable {
    
}

extension Scalable where Self : UIView {
    func scale(){
        UIView.animate(withDuration: 1, animations: {
            self.isHidden = false
            self.alpha = 1
            self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        }) { (true) in
//            self.alpha = 0
//            self.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        }
    }
    
    func deScale(){
        self.alpha = 0
        self.transform = CGAffineTransform.init(scaleX: 0, y: 0)
    }
}
