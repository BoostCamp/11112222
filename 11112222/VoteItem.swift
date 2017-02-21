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
    var text: String?
    var image : UIImage?
    var imageUrl : String?
    var linkAddr : String? // naver api를 사용해서 만든 voteItem의 경우 링크를 가진다.
    var voteCount : Int?
    var isImageSetted : Bool = false
    
    // unique id for find object
    var id : Int?
    
    var isUsingOK : Bool {
        return (text != nil && !(text?.trimmingCharacters(in: .whitespaces).isEmpty)!) || isImageSetted
    }
    
    init(dic: Dictionary<String, Any>) {
        text = dic["description"] as? String
        imageUrl = dic["imageUrl"] as? String
        voteCount = dic["count"] as? Int
    }
    
    init() {
        
    }

    
}
