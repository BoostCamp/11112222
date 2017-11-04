//
//  RootTabBarViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 17..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.tintColor = UIColor.FlatColor.AppColor.ChiliPepper
    }
}
