//
//  Category.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 9..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation
import UIKit
struct Category {
    var image : UIImage
    var name : String
    
    init(icon : UIImage, name: String) {
        self.image = icon
        self.name = name
    }
}
