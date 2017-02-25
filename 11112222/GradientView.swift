//
//  GradientView.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 24..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    override open class var layerClass: AnyClass {
        get{
            return CAGradientLayer.classForCoder()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        let color1 = UIColor.black.withAlphaComponent(0.1).cgColor as CGColor
        let color2 = UIColor.black.withAlphaComponent(0.9).cgColor as CGColor
        gradientLayer.locations = [0.60, 1.0]
        gradientLayer.colors = [color2, color1]
    }
}

