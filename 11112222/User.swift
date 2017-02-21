//
//  User.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation

class User : NSObject{
    // MARK: Properties
    var name: String?
    var image: String?
    
    var isOwner : Bool?
    
    var postHistory: [Card]? // 포스트 히스토리
    var voteHistory: [Card]? // 투표 히스토리
    
    // 두개의 동일한 데이터가 존재할 수 있으니 Card 클래스 안에 플래그를 주어 내가 투표한 게시물임을 알린다.
    var myCard : [Card]? // 뭐가 더 좋을까

    init(name: String, isOwner : Bool = false) {
        self.name = name
        
        self.isOwner = isOwner
    }
    
    init(dic: Dictionary<String, Any>) {
        name = dic["username"] as! String?
        image = dic["profile"] as? String ?? ""
        isOwner = true
    }
}
