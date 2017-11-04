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
    private var currentUser : User?
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
            
            saveUserID(uid)
            print("name \(name) email \(email) photoUrl \(photoUrl) uid \(uid))")
            
            return true
        } else {
            return false
        }
    }
    
    private func saveUserID(_ id: String) {
        UserDefaults.standard.setValue(id, forKey: "uid")
    }
    
    public func getUserID()-> String?{
        let userdefault = UserDefaults.standard
        return userdefault.value(forKey: "uid") as? String
    }
}
