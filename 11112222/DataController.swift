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
    private var cards = [Card]()
    
    var delegate : NetworkResultDelegate?
    
    
    
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
    
    public func fetchUser(id: String ,completion: @escaping (User)-> Void) {
        let userID : String?
        if id.isEmpty {
            userID = FIRAuth.auth()?.currentUser?.uid
        } else {
            userID = id
        }
        
        userRef.child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            //            let username = snapshot.value!["username"] as! String
            //            let user = User.init(username: username)
            if let userdict = snapshot.value as? [String: Any] {
                let user = User(dic: userdict)
                user.userID = snapshot.key
                completion(user)
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    public func fetchUserPost(id: String, completion: @escaping ([Card])->Void) {
        let userID : String?
        if id.isEmpty {
            userID = FIRAuth.auth()?.currentUser?.uid
        } else {
            userID = id
        }
        var userPosts = [Card]()
        baseRef.child("user-posts").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            for item in snapshot.children{
                if let childSnapshot = item as? FIRDataSnapshot {
                    if let cardDict = childSnapshot.value as? [String:AnyObject] {
                        print("snapshot.value \(snapshot.value)")
                        let card = Card(dic: cardDict) // 카드 데이터 만들기 시작하자.
                        card.cardID = snapshot.key
                        userPosts.append(card)
                        
                    }
                }
            }
            completion(userPosts)
        })
    }
    
    public func getCards() -> [Card] {
        return cards
    }
    
    public func addCard(_ card: Card) -> Card {
        cards.append(card)
        return card
    }
    
    public func resetCards() {
        cardRef.removeAllObservers()
        cards.removeAll()
    }
    
    public func successVoteToCard(at: Int, selectedVote: VoteItem) -> Card{
        cards[at].isVoted = true
        if var cardCount = cards[at].voteCount {
            cardCount = cardCount + 1
            cards[at].voteCount = cardCount
        }
        if let userID = UserDefaults.standard.value(forKey: "uid") as? String, let voteID = selectedVote.id{
            cards[at].votes?.updateValue(voteID, forKey: userID)
        }
        
        return cards[at]
        
    }
    
    public func postCard(card : Card) {
        // 1.유저 가저오기
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            print("invalid user")
            return
        }
        
        card.cardID = cardRef.childByAutoId().key
        uploadImageIntoFirebaseStorage(count: 0, card, currentUser, votes: nil)
    }
    
    // recursion func for upload multi image
    private func uploadImageIntoFirebaseStorage(count: Int,_ card: Card,_ user: FIRUser, votes: Dictionary<String,Any>?) {
        if count == card.voteItems.count { // 탈출
            let timestamp = [".sv": "timestamp"]
            let deadline = Date.convertDateToTimeStamp(card._deadLine!)
            let currentUser = user
            let mainColor = UIColor.getMainColorHexValue()
            var cardBody = ["uid": currentUser.uid,
                            "author": currentUser.displayName ?? "익명유저",
                            "title": card.title!,
                            "caID":card.category!.id,
                            "timestamp": timestamp,
                            "deadLine": deadline,
                            "mainColor": mainColor] as [String : Any]
            
            if let photoUrl = currentUser.photoURL?.absoluteString {
                cardBody.updateValue(photoUrl, forKey: "photoURL")
            }
            
            if let body = card.desc {
                cardBody.updateValue(body, forKey: "body")
            }
            
            if let voteItems = votes {
                cardBody.updateValue(voteItems, forKey: "vote-items")
            }
            
            let cardUpdates = ["card-items/\(card.cardID!)": cardBody,
                               "/user-posts/\(currentUser.uid)/\(card.cardID!)": cardBody]
            
            baseRef.updateChildValues(cardUpdates) { (err, ref) in
                print(ref.description())
                if let err = err {
                    print(err.localizedDescription)
                }
                return
            }
            
            self.delegate?.uploadCompleted(result: true)
            return
        } else {
            var voteItem = [String: Any]()
            let vote = card.voteItems[count]
            let voteKey = cardRef.child("vote-items").childByAutoId().key
            if let body = vote.text {
                voteItem.updateValue(body, forKey: "body")
            }
            if let photo = vote.image { // 이미지 있다.
                let imageName = NSUUID().uuidString
                let storageRef = FIRStorage.storage().reference().child("card_images").child("\(imageName).jpg")
                if let uploadData = UIImageJPEGRepresentation(photo, 0.1){
                    storageRef.put(uploadData, metadata: nil){ (metadata, error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            self.delegate?.uploadCompleted(result: false)
                            return
                        }
                        if let imageUrl = metadata?.downloadURL()?.absoluteString {
                            voteItem.updateValue(imageUrl, forKey: "photoURL")
                            voteItem.updateValue(2, forKey: "type")
                            
                            var items = votes ?? [:]
                            items.updateValue(voteItem, forKey: voteKey)
                            self.uploadImageIntoFirebaseStorage(count: count+1,card,user, votes: items)
                        } else {
                            print("metadata download url not exist")
                            self.delegate?.uploadCompleted(result: false)
                            return
                        }
                    }
                }
            }
            else { // 이미지 없다.
                voteItem.updateValue(1, forKey: "type")
                
                var items = votes ?? [:]
                items.updateValue(voteItem, forKey: voteKey)
                self.uploadImageIntoFirebaseStorage(count: count+1,card,user, votes: items)
                
            }
        }
    }
    
    // 투표
    public func vote(to voteItem: VoteItem,_ card: Card, completed: @escaping (Bool)->Void ) {
        var userVoteCount: Int?
        var userVotes : [String:String]?
        
        cardRef.child(card.cardID!).runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
            if var card = currentData.value as? [String: AnyObject], let uid = FIRAuth.auth()?.currentUser?.uid {
                
                var votes : Dictionary<String, String>
                votes = card["votes"] as? [String : String] ?? [:]
                var voteCount = card["voteCount"] as? Int ?? 0
                if let _ = votes[uid] {
                    //                    voteCount -= 1
                    //                    votes.removeValue(forKey: uid)
                    completed(false)
                    return FIRTransactionResult.abort()
                } else {
                    voteCount += 1
                    votes[uid] = voteItem.id
                }
                card["voteCount"] = voteCount as AnyObject?
                card["votes"] = votes as AnyObject?
                userVoteCount = voteCount
                userVotes = votes
                currentData.value = card
                return FIRTransactionResult.success(withValue: currentData)
                
            }
            return FIRTransactionResult.success(withValue: currentData)
            
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
            if committed {
                if let uid = FIRAuth.auth()?.currentUser?.uid {
                    if let votes = userVotes, let count = userVoteCount {
                        let updates = ["voteCount": count, "votes": votes] as [String : Any]
                        
                        if let ownerID = card.uid {
                            self.baseRef.child("user-posts").child(ownerID).child(card.cardID!).updateChildValues(updates, withCompletionBlock: { (error, reference) in
                                if let error = error {
                                    print(error.localizedDescription)
                                    completed(false)
                                }
                                completed(true)
                            })
                        }
                        
                    }

                }
                
                
            }
        }
    }
    public func fetchCard(id: String, completion:@escaping (Card)-> Void){
        cardRef.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            print("dead")
            print(snapshot)
            if let cardDict = snapshot.value as? [String:AnyObject] {
                let card = Card(dic: cardDict) // 카드 데이터 만들기 시작하자.
                card.cardID = snapshot.key
                completion(card)
            }
            
        })
    }
    
    public func fetchCards(with category: Category ,completion: @escaping (Card) -> Void){
        var query : FIRDatabaseQuery!
        if category.type == .home { // 최신순
            getCardBySorted(by: category.id, completed: { (card) in
                completion(card)
            })
            
        } else {
            query = cardRef.queryOrdered(byChild: "caID").queryEqual(toValue: category.id)
            query.observe(.childAdded, with: { (snapshot) in
                if let cardDict = snapshot.value as? [String:AnyObject] {
                    print("snapshot.value \(snapshot.value)")
                    let card = Card(dic: cardDict) // 카드 데이터 만들기 시작하자.
                    card.cardID = snapshot.key
                    completion(self.addCard(card))
                }
            })
        }
    }
    
    private func getCardBySorted(by: String, completed: @escaping (Card)->Void){
        var query : FIRDatabaseQuery!
        switch by {
        case "lastest":
            query = cardRef.queryOrderedByPriority()
        case "deadline":
            let current = Util.getCurrentTimeStamp()
            query = cardRef.queryOrdered(byChild:"deadLine").queryStarting(atValue: current)
        default:
            break
        }
        
        query.observe(.childAdded, with: { (snapshot) in
            if let cardDict = snapshot.value as? [String:AnyObject] {
                print("snapshot.value \(snapshot.value)")
                let card = Card(dic: cardDict) // 카드 데이터 만들기 시작하자.
                card.cardID = snapshot.key
                completed(self.addCard(card))
            }
        })
        
    }
    
    
    
}
