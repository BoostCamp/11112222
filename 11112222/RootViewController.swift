//
//  RootViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 17..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, LoginViewControllerDelegate {
    
    private var loginViewController : LoginViewController {
        let storyboard = UIStoryboard(name: "Join", bundle: Bundle.main)
        
        // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        // connect login delegate
        viewController.delegate = self
        return viewController
    }
    
    private var homeViewController : RootTabBarViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarViewController") as! RootTabBarViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        let user = User(name: "")
        
        
        // observer로 로그인 관리 하는 방법
//        user.addObserver(self, forKeyPath: "isOwner", options: .new, .old, context: nil)
        // userDafault preference로 로그인 관리 하는 방법
//        if let 로그인됨 = userDefaults.bool(forKey: ""), 로그인됨 = true {
//            let homeViewController = HomeViewController()
//            homeViewController.view.frame = view.bounds
//            
//            view.addSubview(homeViewController.view)
//        } else {
//            
//            
//        }
        
        
        
//        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
//            if let user = user {
//                // User is signed in.
//            } else {
//                // No user is signed in.
//            }
//        }  
//        print(LoginManager.sharedInstance().checkIfUserIsLoggedIn())
        if LoginManager.sharedInstance().checkIfUserIsLoggedIn() {
            add(asChildViewController: homeViewController)
        } else {
            add(asChildViewController: loginViewController)
        }
        
//        let userDefaults = UserDefaults.standard
//        if userDefaults.bool(forKey: "login"){
//        } else {
//        }

    }
        
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    
    // MARK: - LoginViewControllerDelegate
    
    func login() {
        remove(asChildViewController: loginViewController)
        add(asChildViewController: homeViewController)
    }
    
    func logout() {
        remove(asChildViewController: homeViewController)
        add(asChildViewController: loginViewController)

    }


}
