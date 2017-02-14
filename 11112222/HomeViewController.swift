//
//  HomeViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // MARK: - Properties
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var categoryCollectionView : UICollectionView!
    let categoryCollectionViewDelegate = CategoryCollectionViewDelegate()
    
    var dataController = DataController.sharedInstance()
    var data : [Card]!

    var isFirstTimeTransform : Bool = true // collectionview property
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = dataController.getCardDummyData()
        
//        MainTableView.rowHeight = UITableViewAutomaticDimension
//        MainTableView.estimatedRowHeight = 375
        
        //register nib for collectionView
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryCell")
        categoryCollectionView.delegate = categoryCollectionViewDelegate
        categoryCollectionView.dataSource = categoryCollectionViewDelegate
        categoryCollectionView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        self.tabBarController?.delegate = self
    }
    
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell") as! CardTableViewCell
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let tableViewCell = cell as? CardTableViewCell else { return }
        
//        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
//        tableViewCell.setupFlowLayout()
    }
    
    
}

// MARK: - TabBarContoller Delegate
extension HomeViewController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is  UINavigationController{
            if let newVC = tabBarController.storyboard?.instantiateViewController(withIdentifier: "EditCardViewController") {
                tabBarController.present(newVC, animated: true)
                return false
            }
        }
        return true
    }
}

