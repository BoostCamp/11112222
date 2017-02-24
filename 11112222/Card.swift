//
//  Card.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation
import Firebase

struct CardNotification {
    static let Name = "CardNotification"
    static let User = "UserNotification"
}

class Card : NSObject {
    // MARK: Properties
    var cardID : String? // 카드 ID
    var uid : String? // 게시자 파이어베이스 ID
    var username : String?
    var photoURL : String?
    var categoryID : String?
    var voteCount : Int?
    var mainColor : Int?
    //    var user : User? // 게시자
    var title : String?
    var desc : String?
    var _date : Date? // 게시 날짜
    var _deadLine : Date?// 투표 기한 날짜
    var voteItems = [VoteItem]()
    var votes : [String:String]?
    var comments : [CardComment]?
    var postedAt : String {
        return Util.timeAgoSinceDate(_deadLine!, numericDates: true)
    }
    
    var untilAt : (Bool,String) {
        return Util.timeLeftFromNow(_deadLine!)
    }
    // if user vote this card
    var isVoted : Bool = false
    var isOwner : Bool = false
    
    // card has category
    var category: Category?
    
    var isClosed : Bool = false // 게시자에 한해 게시물을 닫을 수 있고, 투표기한을 둘까? 고민되는군
    
    var isPostable : Bool {
        print("isPostable \(voteItemsIsFilled() && defaultValueIsFilled())")
        return voteItemsIsFilled() && defaultValueIsFilled()
    }
    
    init(dic: Dictionary<String, Any>) {
        if let id = dic["uid"] as? String {
            uid = id
        }
        if let name = dic["author"] as? String {
            username = name
        }
        if let photoURL = dic["photoURL"] as? String {
            self.photoURL = photoURL
        }
        categoryID = (dic["caID"] as? String)!
        title = (dic["title"] as? String)!
        
        if let body = dic["body"]  {
            desc = body as? String
        }
        
        // 게시날짜
        if let timestamp = dic["timestamp"] as? Double{
            _date = Date(timeIntervalSince1970: timestamp / 1000)
        }
        // 데드라인
        if let deadLine = dic["deadLine"] as? Double {
            _deadLine = Date(timeIntervalSince1970: deadLine / 1000)
        }
        
        
        if let voteCount = dic["voteCount"] as? Int {
            self.voteCount = voteCount
        } else {
            self.voteCount = 0
        }
        
        if let votes = dic["votes"] as? [String : String] {
            self.votes = votes
        } else {
            self.votes = [:]
        }
        
        print("voteCount \(voteCount)")
        print("voteCount \(votes)")
        if let currentUserID = LoginManager.sharedInstance().getUserID(){
            //투표여부
            if let _ = votes?[currentUserID] {
                isVoted = true
            } else {
                isVoted = false
            }
            //게시여부
            if uid == currentUserID {
                isOwner = true
            } else {
                isOwner = false
            }

        } else {
            isVoted = false
        }
        
        //투표아이템
        if let items = dic["vote-items"] as! [String : Any]?{
            for item in items  {
                let voteItem = VoteItem(dic: item.value as! Dictionary<String, Any>)
                voteItem.id = item.key
                
                voteItems.append(voteItem)
            }
            
        }
        //메인칼라
        if let mainColor = dic["mainColor"] as? Int {
            self.mainColor = mainColor
        }
        
    }
    
    override init() {
        
        // 업로드 화면을 위한 초기화
        for i in  0...1 {
            let item = VoteItem()
            voteItems.append(item)
        }
    }
    
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
        
        guard let title = self.title, !title.trimmingCharacters(in: .whitespaces).isEmpty,
            _deadLine != nil, category != nil else { return false }
        
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


