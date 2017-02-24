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
    
    var isFirtInit : Bool = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //register nib for collectionView
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)


        categoryCollectionView.register(nib, forCellWithReuseIdentifier: "categoryCell")
        self.tabBarController?.delegate = self
        
        // add observer
        NotificationCenter.default.addObserver(self, selector: #selector(goToResultViewController), name: NSNotification.Name(rawValue: CardNotification.Name), object: nil)
    }
    
    deinit {

        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: CardNotification.Name), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isFirtInit {
            categoryCollectionView.delegate?.collectionView!(categoryCollectionView, didSelectItemAt: IndexPath(row:0,section:0))
            categoryCollectionView.selectItem(at: IndexPath(row:0,section:0), animated: false, scrollPosition: .init(rawValue: 10))
            
            isFirtInit = true
        }
    }
    
    @objc private func goToResultViewController(notification: Notification){
        if let card = notification.object as? Card {
            let storyboard = UIStoryboard(name: "VoteResult", bundle: nil)
            if let resultVC = storyboard.instantiateViewController(withIdentifier: "VoteResultViewController") as? VoteResultViewController {
                resultVC.card = card
                present(resultVC, animated: true, completion: nil)
            }
        }
    }
    
    func fetchCardsData(with category: Category) {
        
        let dataController = DataController.sharedInstance()
        if !dataController.getCards().isEmpty {
            dataController.resetCards()
            mainTableView.reloadData()
        }
        
        dataController.fetchCards(with: category){ (card) in
            // 로딩바 없애고 보여주자
            self.insertCardIntoTableView(card)
        }
    }
    
    private func insertCardIntoTableView(_ card: Card) {
        mainTableView.beginUpdates()
        mainTableView.insertRows(at: [IndexPath(row:DataController.sharedInstance().getCards().count-1, section:0)], with: .bottom)
        mainTableView.endUpdates()
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataController.sharedInstance().getCards().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell") as! CardTableViewCell
        cell.index = indexPath.row
        let card = DataController.sharedInstance().getCards()[indexPath.row]
        cell.configureCell(card : card)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let cell = cell as! CardTableViewCell
        cell.collectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width
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

