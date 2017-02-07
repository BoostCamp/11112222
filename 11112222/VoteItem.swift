//
//  VoteItem.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation

class VoteItem {
    // Mark: Properties
    var text: String
    var image : String?
    var linkAddr : String? // naver api를 사용해서 만든 voteItem의 경우 링크를 가진다.
    var voteCount : Int?
    
    init(text : String) {
        self.text = text
    }
    
}
