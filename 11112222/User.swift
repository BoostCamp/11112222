//
//  User.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation

class User {
    // MARK: Properties
    var name: String
    var image: String?
    
    var postHistory: [Card]?
    var voteHistory: [Card]?
    
    init(name: String) {
        self.name = name
    }
    
}
