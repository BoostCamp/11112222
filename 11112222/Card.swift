//
//  Card.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation
import Firebase

class Card : NSObject {
    // MARK: Properties
    var by : String?
    var user : User? // 게시자
    var title : String?
    var desc : String?
    var voteItems = [VoteItem]()
    var comments : [CardComment]?
    
    // if user vote this card
    var isVote : Bool?
    
    // card has category
    var category: Category?
    var categoryID : String?
    
    var isClosed : Bool = false // 게시자에 한해 게시물을 닫을 수 있고, 투표기한을 둘까? 고민되는군
    
    var isPostable : Bool {
        toString()
        print("isPostable \(voteItemsIsFilled() && defaultValueIsFilled())")
        return voteItemsIsFilled() && defaultValueIsFilled()
    }
    
    init(dic: Dictionary<String, Any>) {
        self.by = dic["by"] as! String?
        self.categoryID = dic["into"] as! String?
        self.desc = dic["description"] as? String ?? ""
        self.title = dic["title"] as? String ?? ""
    }
    
//    init(owner user: User, title: String, description: String, options: [VoteItem] , isVote : Bool = false, category: Category, isClosed: Bool = false) {
//        self.user = user
//        self.title = title
//        self.desc = description
//        self.voteItems = options
//        self.isVote = isVote
//        self.category = category
//        self.isClosed = isClosed
//    }
    
    override init() {
        
        // 업로드 화면을 위한 초기화
        for i in  0...1 {
            let item = VoteItem()
            item.id = i
            voteItems.append(item)
        }
    }

    // 문제 된다 이거
    private func voteItemsIsFilled() -> Bool {
        var removeFlag : Bool = false // 데이터 삭제가 필요하다
        var removeIndex : Int? // 최초 nil
        
        guard !(voteItems.count < 2) else{
            return false
        }
        
        for i in 0..<voteItems.count {
            if voteItems[i].isUsingOK && removeFlag { // ok 이야 근데 removeindex != nil 이야 이건 저 위에 invalidate가 있다는 뜻이야 그럼 안돼 중간에 빈게 있으면 안돼
                return false
            }
            
            if ( !voteItems[i].isUsingOK ){ // 이 이후 계속 remove 인덱스로 들어 왓다면
                
                if !removeFlag {
                    removeIndex = i
                    removeFlag = true
                }
            }
        }
        
        
        // 3. 중간에 빈거 없이 정리된 상태 일거야.
        guard removeIndex == nil else {
            let count = voteItems.count - removeIndex!

            for _ in 0..<count {
                
                print("removeIndex \(voteItems.popLast())")
            }
            
            return true
        }
        
        return true
    }
    
    private func defaultValueIsFilled() -> Bool {
        
        guard let title = self.title, !title.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        guard self.category != nil else { return false }
        
        return true
    }
    
    
    // toString
    func toString(){
        var tt = " "
        
        for i in voteItems {
            if let text = i.text {
                tt = tt + " [ \(text) ]"
            } else {
                tt = tt + " [ nil ]"
            }
            
        }
        
        print("\(voteItems.count) \(tt)")

    }
}


