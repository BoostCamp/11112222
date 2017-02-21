//
//  LoginManager.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 18..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import Foundation
import Firebase
class LoginManager {
    
    struct StaticInstance {
        static var instance: LoginManager?
    }
    
    class func sharedInstance() -> LoginManager {
        if StaticInstance.instance == nil {
            StaticInstance.instance = LoginManager()
        }
        return StaticInstance.instance!
    }
    
    public func checkIfUserIsLoggedIn() -> Bool {
        if let user = FIRAuth.auth()?.currentUser {
            let name = user.displayName!
            let email = user.email!
            let photoUrl = user.photoURL!
            let uid = user.uid
            
            print("name \(name) email \(email) photoUrl \(photoUrl) uid \(uid))")
            
            return true
        } else {
            return false
        }
    }
}
