//
//  CardComment.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation

class CardComment {
    // MARK: Properties
    var user : User
    var text : String
    
    init(writer user: User, description text: String) {
        self.user = user
        self.text = text
    }
}
