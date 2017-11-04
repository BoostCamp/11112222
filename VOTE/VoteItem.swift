//
//  VoteItem.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation
import UIKit


class VoteItem {
    // Mark: Properties
    var id: String?
    var text: String?
    var imageUrl : String?
    var type:Int?
    var linkAddr : String? // naver api를 사용해서 만든 voteItem의 경우 링크를 가진다.
    var voteCount : Int = 0
    var isImageSetted : Bool = false
    var image: UIImage?
    var isVote : Bool = false
    // unique id for find object
    
    var isUsingOK : Bool {
        return (text != nil && !(text?.trimmingCharacters(in: .whitespaces).isEmpty)!) || isImageSetted
    }
    
    init(dic: Dictionary<String, Any>) {
        type = dic["type"] as? Int
        
        if let body = dic["body"] {
            text = body as? String
        }
        
        if let photoURL = dic["photoURL"] as? String {
            imageUrl = photoURL
        }
    }
    
    init() {
        
    }
    
    
}
