//
//  VoteResultViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 23..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class VoteResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var card : Card?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        fetchCard()
        
    }

    @IBAction func doneButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func fetchCard(){
        if let cardID = card?.cardID {
            DataController.sharedInstance().fetchCard(id: cardID) { (card) in
//                self.card = card
//                self.tableView.reloadData()
            }
        }
    }
    //MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let card = self.card {
            return card.voteItems.count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoteResultHeaderCell") as! VoteResultHeaderCell
            cell.configureCell(card: card!)
            return cell
        }
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoteResultBodyTableViewCell") as! VoteResultBodyTableViewCell
        if let card = self.card {
            cell.configureCell(card: card, vote: card.voteItems[indexPath.row-1])
        }
        return cell
        
    }
}
