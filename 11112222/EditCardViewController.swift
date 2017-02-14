//
//  EditCardViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class EditCardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // MARK: - Properties
    @IBOutlet weak var editCardTableView : UITableView!
    var voteItems = [VoteItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        editCardTableView.rowHeight = UITableViewAutomaticDimension
        editCardTableView.estimatedRowHeight = 100
        editCardTableView.allowsSelection = false // selection false

        // init post data
        for _ in  0...1 {
            voteItems.append(VoteItem())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isKeyboardShowing { // vc가 사라질 때 키보드가 보이고 있다면 사라지게 하자.
            if let textField = findFirstResponder() as? UITextField {
                textField.resignFirstResponder()
            }
        }
        unsubscribeFromKeyboardNotifications()
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Action
    @IBAction func onCancelClick() {
        dismiss(animated: true, completion: nil)
    }
    
    func showAtionSheetForPhoto() {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .default) { action -> Void in
            //Code for launching the camera goes here
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
        actionSheetController.addAction(takePictureAction)
        
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .default) { action -> Void in
            //Code for picking from camera roll goes here
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            self.present(pickerController, animated: true, completion: nil)

        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row != 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "editCardCell", for: indexPath) as! EditCardTableCell
            cell.optionLabel.placeholder = "option \(indexPath.row)"
//            cell.btnCamera.tag = indexPath.row
            cell.tag = indexPath.row
            cell.configureCell()
            cell.delegate = self
//            cell.btnCamera.addTarget(self, action:#selector(showAtionSheetForPhoto(_:)), for: UIControlEvents.touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editCardHeaderCell") as! EditCardTableHeaderCell
            cell.configureCell()
            cell.delegate = self
            cell.tag = indexPath.row
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1 + voteItems.count // 1은 0번째 로우
    }

    // MARK: - TableView Delegate
    
    
    // MARK: - calculate over rapping keyboard and hide & show keyboard
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    var isKeyboardShowing : Bool = false

    func keyboardWillShow(_ notification:Notification) {
        if isKeyboardShowing {
            return
        }
        
        let textField = findFirstResponder() as? UITextField
    
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {

            var frame = editCardTableView.frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.4)
            frame.size.height -= keyboardSize.height
            editCardTableView.frame = frame
            
            if textField != nil {
                let rect = editCardTableView.convert(textField!.bounds, from: textField)
                editCardTableView.scrollRectToVisible(rect, animated: false)
            }
            UIView.commitAnimations()
            
        }
        
        isKeyboardShowing = true

    }
    
    func keyboardWillHide(_ notification:Notification){
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var frame = editCardTableView.frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.2)
            frame.size.height += keyboardSize.height
            editCardTableView.frame = frame
            UIView.commitAnimations()
        }
        
        isKeyboardShowing = false
    }
    
    func findFirstResponder() -> UIResponder? {

        for v2 in self.editCardTableView.visibleCells {
            for v3 in v2.contentView.subviews {
                if v3.isFirstResponder {
                    return (v3 as UIResponder)
                }
            }
        }

        return nil
    }
    
    func getKeyboardRect(_ notification:Notification) -> CGRect {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var cameraSelectedCell : EditCardTableCell? //이거 바꿔보자
}

extension EditCardViewController : EditCardHeaderViewDelegate, EditCardItemViewDelegate {
    
    // EditCardHeaderView Delegate
    func emptyViewTapped(cell: EditCardTableHeaderCell) {
        if isKeyboardShowing {
            if let textField = findFirstResponder() as? UITextField {
                textField.resignFirstResponder()
            }
        } else {
            // 입력 창 띄우기
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditCommentViewController") as! EditCommentViewController
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc.delegate = self
            if cell.descLabel.text != nil {
                vc.input = cell.descLabel.text
                vc.state = EditCommentViewController.EditState.edit
            } else {
                vc.state = EditCommentViewController.EditState.post
            }
            present(vc, animated: true, completion: nil)
        }
    }
    
    
    // 입력 완료 시 콜백
    func didEndEditing(tag: Int, text: String, trimmed: String) {
        var voteItem : VoteItem?
        voteItem = voteItems[tag - 1]
        
        if voteItem == nil {
            // 성성
            voteItem = VoteItem()
        }
        
        if trimmed.isEmpty {
            voteItem?.text = nil
        } else {
            voteItem?.text = text
            if tag == voteItems.count {
                // append new Data
                voteItems.append(VoteItem())
                editCardTableView.reloadData()
            }
        }

       
    }
    // EditCardItemView Delegate
    func pickImageClick(cell: EditCardTableCell) {
        cameraSelectedCell = cell
        showAtionSheetForPhoto();
    }
}


// MARK: - UIImagePickerController Delegate
extension EditCardViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                if let editCell = cameraSelectedCell {
                    editCell.btnCamera.setImage(image, for: .normal)
                    editCardTableView.reloadData()
//                    editCardTableView.indexPathForSelectedRow
//                    editCardTableView.cellForRow(at: <#T##IndexPath#>)
                }
            }
            
            dismiss(animated: true, completion: nil)

        }
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}

// MARK: - EditCommentViewController Delegate
extension EditCardViewController : EditCommentViewControllerDelegate {
    func endEdittingWithText(message: String) {
        let cell = editCardTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! EditCardTableHeaderCell
        cell.emptyView.isHidden = true
        cell.descLabel.text = message
        cell.descLabel.numberOfLines = 0
        cell.descLabel.sizeToFit()
        
    }
}


