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
    let image : UIImage
    let name : String
    let type : CategoryType
    let id : String
    init(type: CategoryType,id : String,icon : UIImage,name: String) {
        self.image = icon
        self.name = name
        self.type = type
        self.id = id
    }
    
    enum CategoryType {
        case home
        case upload
    }
}
