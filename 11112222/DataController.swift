//
//  DataController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 8..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation
import UIKit

class DataController {
    
    var cards : [Card]?
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
    
    
    // 여기서 모델들을 가지고 있자.
    func getCardDummyData() -> [Card] {
        if cards == nil {
            cards = [Card.init(writer: User.init(name: "dongyoon"), title: "11112222 해주세요", description: "2", options: [VoteItem(), VoteItem(),VoteItem(),VoteItem()], category: Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "쇼핑"))
                , Card.init(writer: User.init(name: "dongyoon"), title: "다시 태어나면 되고싶은 선호하는 분위기는? 11112222", description: "2", options: [VoteItem(), VoteItem(), VoteItem() ], category: Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "일상"))
                , Card.init(writer: User.init(name: "dongyoon"), title: "도와주세요!!!", description: "2", options: [VoteItem(),VoteItem()], category: Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "영화"))]
        }
        
        return cards!
    }
    
    func getCategoryDummyData() -> [Category] {
        
        if categories == nil {
            categories = [Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "마감순")
                ,Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "인기순")
                , Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "최신순")
                , Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "영화추천")
                , Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "쇼핑 11112222해주세요")
                , Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "일상")
                , Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "남성")
                , Category.init(icon: UIImage.init(named: "pokemon.png")!, name: "여성")]
        }

        return categories!
    }
    
    
}
