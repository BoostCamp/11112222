//
//  CategoryGenerator.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 20..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation

class CategoryGenerator {
    private var categories = [Category]()
    
    struct StaticInstance {
        static var instance: CategoryGenerator?
    }
    
    class func sharedInstance() -> CategoryGenerator {
        if StaticInstance.instance == nil {
            StaticInstance.instance = CategoryGenerator()
        }
        return StaticInstance.instance!
    }
    
    init() {
        categories.append(Category.init(type: Category.CategoryType.home, id: "lastest", icon: #imageLiteral(resourceName: "pokemon"), name: "최신순"))
        categories.append(Category.init(type: Category.CategoryType.home, id: "deadline", icon: #imageLiteral(resourceName: "pokemon"), name: "마감순"))
        categories.append(Category.init(type: Category.CategoryType.upload, id: "shopping", icon: #imageLiteral(resourceName: "pokemon"), name: "쇼핑"))
        categories.append(Category.init(type: Category.CategoryType.upload, id: "daily", icon: #imageLiteral(resourceName: "pokemon"), name: "일상"))
        categories.append(Category.init(type: Category.CategoryType.upload, id: "movie", icon: #imageLiteral(resourceName: "pokemon"), name: "영화"))
        categories.append(Category.init(type: Category.CategoryType.upload, id: "man", icon: #imageLiteral(resourceName: "pokemon"), name: "남성"))
        categories.append(Category.init(type: Category.CategoryType.upload, id: "woman", icon: #imageLiteral(resourceName: "pokemon"), name: "여성"))
        
    }
    
    var homeCategories : [Category] {
        return categories
    }
    
    public func getUploadCategories() -> [Category] {
        return categories.filter { (category) -> Bool in
            category.type == Category.CategoryType.upload
        }
        
    }
}
