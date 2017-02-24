//
//  UserViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit
import Nuke

class UserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var cards = [Card]()
    let userID : String = ""
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var postCount: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataController.sharedInstance().fetchUser(id: userID) { (user) in
            self.setUserProfileView(user)
        }
        DataController.sharedInstance().fetchUserPost(id: userID) { (cards) in
            self.cards = cards
            self.collectionView.reloadData()
            self.voteCount.text = String(cards.count)
        }
        
        setupFlowLayout()
        
    }
    
    func setUserProfileView(_ user: User){
        usernameLabel.text = user.name
        
        profileImageView.image = nil
        if let imageUrl = user.image {
            if let url = URL.init(string: imageUrl){
                Nuke.loadImage(with: url, into: profileImageView)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        
        cell.configureCell(card: cards[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        goToResultViewController(card)
    }
    
    func goToResultViewController(_ card: Card) {
        let storyboard = UIStoryboard(name: "VoteResult", bundle: nil)
        if let resultVC = storyboard.instantiateViewController(withIdentifier: "VoteResultViewController") as? VoteResultViewController {
            resultVC.card = card
            present(resultVC, animated: true, completion: nil)
        }

    }
    
    func setupFlowLayout() {
        
        let items: CGFloat = 2.0
        let space: CGFloat = 3.0
        let width: CGFloat = self.view.frame.width
        let dimension = (width - ((items - 1) * space)) / items
        
        if flowLayout != nil {
            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = 8.0 - items
            flowLayout.itemSize = CGSize(width: dimension,height: dimension)
        }
    }


}
