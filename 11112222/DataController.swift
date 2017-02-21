//
//  DataController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 8..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation
import Firebase
import UIKit

protocol NetworkResultDelegate {
    func uploadCompleted(result: Bool)
}

class DataController : NSObject {
    static var BASE_URL = "https://project-3095891393474636091.firebaseio.com/"
    
    private var BASE_REF = FIRDatabase.database().reference(fromURL: BASE_URL)
    private var CARD_REF = FIRDatabase.database().reference(fromURL: "\(BASE_URL)/card-items")
    private var VOTE_REF = FIRDatabase.database().reference(fromURL: "\(BASE_URL)/vote-items")
    
    private var USER_REF = FIRDatabase.database().reference(fromURL: "\(BASE_URL)/users")
    
    
    var baseRef : FIRDatabaseReference {
        return BASE_REF
    }
    
    var userRef : FIRDatabaseReference {
        return USER_REF
    }
    
    var cardRef : FIRDatabaseReference {
        return CARD_REF
    }
    
    var voteRef : FIRDatabaseReference {
        return VOTE_REF
    }
    
    var delegate : NetworkResultDelegate?
    
    
    var cards = [Card]()
    var categories : [Category]?
    
    
    struct StaticInstance {
        static var instance: DataController?
    }
    
    class func sharedInstance() -> DataController {
        if StaticInstance.instance == nil {
            StaticInstance.instance = DataController()
        }
        return StaticInstance.instance!
    }
    
    // MARK: - Firebase save data
    var childUpdates = [String: Any]()
    var cardUpdate = [String: Any]()
    
    public func postCardIntoFirebase(card : Card) {
        // 1.유저 가저오기
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            print("invalid user")
            return
        }
        let userID = currentUser.uid
        
        // successfully authenticated user
        
        let cardID = cardRef.childByAutoId().key
        let timestamp = NSDate().timeIntervalSince1970 * 1000
        cardUpdate = ["by": userID, "title": card.title!, "description": card.desc ?? "데이터 없음", "into": card.category!.id,"timestamp" : timestamp]
        childUpdates.updateValue(cardUpdate, forKey: "card-items/\(cardID)")
        childUpdates.updateValue(true, forKey: "/user-posts/\(userID)/\(cardID)")
        
        
        uploadImageIntoFirebaseStorage(count: 0, card: card, cardID: cardID)
        
    }
    
    // recursion func for upload multi image
    private func uploadImageIntoFirebaseStorage(count: Int, card: Card, cardID: String) {
        if count == card.voteItems.count { // 탈출
            // 다른거 수행
            //childUpdates.updateValue(cardUpdate, forKey: "/card-items/\(cardID)")
            baseRef.updateChildValues(childUpdates) { (err, ref) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                self.childUpdates.removeAll()
                self.cardUpdate.removeAll()
                
                self.delegate?.uploadCompleted(result: true)
                return
            }
        } else {
            let voteItemID = voteRef.childByAutoId().key
            
            var voteDic = [String: Any]()
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("card_item_images").child("\(imageName).png")
            let vote = card.voteItems[count]
            
            
            // 공통 데이터
            cardUpdate.updateValue(true, forKey:"voteitems/\(voteItemID)")
            
            voteDic.updateValue(vote.text ?? "", forKey: "description")
            voteDic.updateValue(0 , forKey: "count")
            
            if let image = vote.image { // 이미지 있다.
                if let uploadData = UIImagePNGRepresentation(image) {
                    storageRef.put(uploadData, metadata: nil){ (metadata, error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            return
                        }
                        
                        if let imageUrl = metadata?.downloadURL()?.absoluteString {
                            voteDic.updateValue(imageUrl, forKey: "imageUrl")
                            self.childUpdates.updateValue(voteDic, forKey: "/vote-items/\(cardID)/\(voteItemID)")
                            self.uploadImageIntoFirebaseStorage(count: count+1, card: card, cardID: cardID)
                        } else {
                            print("이상한 에러")
                            return
                        }
                    }
                }
            } else { // 이미지 없다.
                voteDic.updateValue("", forKey: "imageUrl")
                childUpdates.updateValue(voteDic, forKey: "/vote-items/\(cardID)/\(voteItemID)")
                uploadImageIntoFirebaseStorage(count: count+1, card: card, cardID: cardID)
            }
            
        }
    }
    
    public func fetchCardDataFromFIR(with category: Category ,completion: @escaping (Card) -> Void){
        
        var query : FIRDatabaseQuery!
        if category.type == .home { // 최신순
            switch category.id {
            case "lastest":
                query = cardRef.queryOrdered(byChild:"timestamp").queryLimited(toFirst: 30)
            case "deadline":
                print(category.id)
            default:
                break
            }
        } else {
            query = cardRef.queryOrdered(byChild: "into").queryEqual(toValue: category.id).queryLimited(toFirst: 15)
        }

        
        query.observe(.childAdded, with: { (snapshot) in // chaining query ㅜㅜ
            if let cardDict = snapshot.value as? [String:AnyObject] {
                let cardID = snapshot.key
                let card = Card(dic: cardDict) // 카드 데이터 만들기 시작하자.
                
                self.userRef.child(card.by!).observeSingleEvent(of: .value, with: { (userSnapshot) in
                    if let userDict = userSnapshot.value as? [String: AnyObject] {
                        let user = User(dic: userDict)
                        card.user = user
                        
                        self.voteRef.child(cardID).observeSingleEvent(of: .value, with: { (votesSnapshot) in
                            for voteSnapshot in votesSnapshot.children {
                                if let vote = voteSnapshot as? FIRDataSnapshot {
                                    if let voteDict = vote.value as? [String : AnyObject] {
                                        let voteItem = VoteItem(dic: voteDict)
                                        card.voteItems.append(voteItem)
                                    }
                                }
                            }
                            self.cards.append(card)
                            completion(card)
                        })
                    }
                })
                
            }
            
        }, withCancel: nil)
    }
}
