//
//  CategoryTableViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 15..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class CategoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selectedCategory : Category?
    let categories = CategoryGenerator.sharedInstance().getUploadCategories()
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        let item = categories[indexPath.row]
        cell.configureCell(category: item)
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
    }
    
    
    // MARK: - IBAction
    @IBAction func cancelClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categorySelectDone" {
            guard let selected = selectedCategory, let cardEditVC = segue.destination as? EditCardViewController else {
                return
            }
            cardEditVC.setCategory(selected: selected)
        }
    }
    

}
