//
//  LoginViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 17..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit
import Firebase


protocol LoginViewControllerDelegate {
    func login()
    func logout()
}

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    var delegate : LoginViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // Do any additional setup after loading the view.
        
        
        logoutButton.backgroundColor = UIColor.FlatColor.Gray.WhiteSmoke
    }
    
    // IBAction
    @IBAction func signOutClick(){
        try! FIRAuth.auth()!.signOut()
    }
    
    // MARK: - GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,accessToken: (authentication?.accessToken)!)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user 
            print("user logged in...")

            let usersRef = DataController.sharedInstance().userRef.child(uid)
            let value = ["username" : user?.displayName, "email" : user?.email, "profile" : user?.photoURL?.absoluteString]
            usersRef.updateChildValues(value, withCompletionBlock: { (err, ref) in
                
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                print("saved user successfully into firebase database")
                self.login()
            })
        })
    }
    
    
    // signout
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        if let error = error {
            print(error.localizedDescription)
        }
//        setUserLoginPreference(flag: false)
        delegate?.logout()
    }
    
    private func setUserLoginPreference(flag : Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(flag, forKey: "login")
    }
    
    private func login(){
//        setUserLoginPreference(flag: true)
        delegate?.login()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
