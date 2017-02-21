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
    
    let categories: [Category] = CategoryGenerator.sharedInstance().homeCategories

    //let categoryCollectionViewDelegate = CategoryCollectionViewDelegate()
    
    var cards = [Card]()
    var isFirtInit : Bool = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MainTableView.rowHeight = UITableViewAutomaticDimension
//        MainTableView.estimatedRowHeight = 375
        
        //register nib for collectionView
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)


        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.allowsSelection = true
        categoryCollectionView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        self.tabBarController?.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isFirtInit {
            categoryCollectionView.delegate?.collectionView!(categoryCollectionView, didSelectItemAt: IndexPath(row:0,section:0))
            categoryCollectionView.selectItem(at: IndexPath(row:0,section:0), animated: false, scrollPosition: .left)
            
            isFirtInit = true
        }
    }
    
    func fetchCardsData(with category: Category) {
        
        let dataController = DataController.sharedInstance()
        if !dataController.cards.isEmpty {
            dataController.cards.removeAll()
            mainTableView.reloadData()
        }
        dataController.fetchCardDataFromFIR(with: category){ (card) in
            // 로딩바 없애고 보여주자
            print("카드 추가됨")
            self.addCard(card)
        }
    }
    
    private func addCard(_ card: Card) {
        mainTableView.beginUpdates()
        mainTableView.insertRows(at: [IndexPath(row:DataController.sharedInstance().cards.count-1, section:0)], with: .bottom)
        mainTableView.endUpdates()
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataController.sharedInstance().cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell") as! CardTableViewCell
        cell.index = indexPath.row
        cell.configureCell(card : DataController.sharedInstance().cards[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){

        let cell = cell as! CardTableViewCell
        cell.collectionView.reloadData()
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

