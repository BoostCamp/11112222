//
//  Card.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation

class Card {
    // MARK: Properties
    var user : User
    var title : String
    var description : String
    var voteItems : [VoteItem]
    var comments : [CardComment]?
    
    // if user vote this card
    var isVote : Bool
    
    // card has category
    var category : Category
    
    
    var isClosed : Bool? // 게시자에 한해 게시물을 닫을 수 있고, 투표기한을 둘까? 고민되는군
    
    init(writer user: User, title: String, description: String, options: [VoteItem] , isVote : Bool = false, category: Category) {
        self.user = user
        self.title = title
        self.description = description
        self.voteItems = options
        self.isVote = isVote
        self.category = category
    }
}
