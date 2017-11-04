//
//  EditCardViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class EditCardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NetworkResultDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var editCardTableView : UITableView!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var card = Card()
    var optionItemCount = 2
    private var dpShowDateVisible = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editCardTableView.rowHeight = UITableViewAutomaticDimension
        editCardTableView.estimatedRowHeight = 100
        editCardTableView.allowsSelection = true // selection false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cancelButton.tintColor = UIColor.FlatColor.AppColor.ChiliPepper
        doneButton.tintColor = UIColor.FlatColor.AppColor.ChiliPepper
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
    
    private func toggleShowDateDatepicker () {
        dpShowDateVisible = !dpShowDateVisible
        
        editCardTableView.beginUpdates()
        editCardTableView.endUpdates()
    }
    // MARK: - Action
    @IBAction func onCancelClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onNextClick(_ sender: Any) {
        if card.isPostable {
            DataController.sharedInstance().delegate = self
            print("ffffff\(card.desc)")
            DataController.sharedInstance().postCard(card: self.card)
        } else {
            showAlertView()
        }
    }
    // result delegate
    func uploadCompleted(result: Bool) {
        print("result:\(result)")
        if result {
            // 화면 끄자
            dismiss(animated: true, completion: nil)
            
        } else {
            // 에러
            
        }
    }
    
    
    // show alert view
    func showAlertView() {
        let dimissAlertController: UIAlertController = UIAlertController(title: nil, message: "입력 폼이 완성되지 않았습니다", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "확인", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
            //self.placeholderTextView.textView.becomeFirstResponder()
        }
        dimissAlertController.addAction(cancelAction)
        //Present the AlertController
        self.present(dimissAlertController, animated: true, completion: nil)
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
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editCardHeaderCell") as! EditCardTableHeaderCell
            cell.configureCell()
            cell.delegate = self
            cell.categoryButton.addTarget(self, action: #selector(goToCategoryController), for: UIControlEvents.touchUpInside)
            
            cell.tag = indexPath.row
            return cell
            
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "dpShowCell", for: indexPath)
            return cell
        } else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "dpCell") as! DeadLinePickerCell
            cell.delegate = self
            cell.configureCell()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editCardCell", for: indexPath) as! EditCardTableCell
            cell.optionLabel.placeholder = "option \(indexPath.row-2)"
            cell.tag = indexPath.row
            cell.configureCell()
            cell.delegate = self
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionItemCount + 3 // category,title,description, pickerview,
    }
    
    
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            
            toggleShowDateDatepicker()
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = self.editCardTableView.rowHeight
        guard indexPath.row != 2 else {
            if !dpShowDateVisible && indexPath.row == 2{
                if tableView.cellForRow(at: indexPath) != nil{
                    let cell = tableView.cellForRow(at: indexPath) as! DeadLinePickerCell
                    cell.datePickerView.isHidden = true
                }
                height = 0
            } else {
                if tableView.cellForRow(at: indexPath) != nil{
                    let cell = tableView.cellForRow(at: indexPath) as! DeadLinePickerCell
                    cell.datePickerView.isHidden = false
                }
            }
            return height
        }
        
        return height
    }
    
    
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
    
    
    // MARK: - Navigation
    @IBAction func unwindToEditCardEditController(segue: UIStoryboardSegue) {
        
    }
    
    func goToCategoryController() {
        performSegue(withIdentifier: "CategoryTableViewController", sender: self)
    }
    
    var cameraSelectedCell : EditCardTableCell? //이거 바꿔보자
}

extension EditCardViewController : EditCardHeaderViewDelegate, EditCardItemViewDelegate{
    
    //MARK: - EditCardHeaderView Delegate
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
            present(vc, animated: false, completion: nil)
        }
    }
    
    //MARK: - UIPickerViewDelegate
    
    // 제목
    func titleEndEditting(text: String) {
        card.title = text
    }
    
    // 입력 완료 시 콜백 from EditCardTableCell
    func didEndEditing(tag: Int, text: String, trimmed: String) {
        
        let index = tag - 3
        // 1. 빈 데이터 추가
        if index == card.voteItems.count {
            card.voteItems.append(VoteItem()) // Todo
        }
        // 2. data 변경
        card.voteItems[index].text = text
        card.toString()
        // 3. 화면 변경
        guard !trimmed.isEmpty else {
            
            return
        }
        guard index == self.optionItemCount - 1  else { return }
        self.optionItemCount += 1
        self.editCardTableView.insertRows(at:[IndexPath(row:optionItemCount+2,section:0)], with: .fade) // 나중에 고치자!!!!
    }
    
    // EditCardItemView Delegate
    func pickImageClick(cell: EditCardTableCell) {
        cameraSelectedCell = cell
        showAtionSheetForPhoto();
    }
    
    func setCategory(selected: Category) {
        let cell = editCardTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! EditCardTableHeaderCell
        
        cell.categoryButton.setTitle(selected.name, for: UIControlState.normal)
        
        // save category
        card.category = selected
    }
}


// MARK: - UIImagePickerController Delegate
extension EditCardViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let editCell = cameraSelectedCell {
                editCell.btnCamera.setImage(image, for: .normal)
                editCardTableView.reloadData()
                let index = editCell.tag - 3
                card.voteItems[index].isImageSetted = true
                card.voteItems[index].image = image
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
        
        // save desc
        card.desc = message
        
    }
}

extension EditCardViewController : DeadLinePickerCellDelegate {
    
    func pickerValueChanged(date: Date) {
        if let cell = editCardTableView.cellForRow(at: IndexPath(row:1, section:0)){
            if let label = cell.contentView.viewWithTag(20) {
                card._deadLine = Date.localTime(date: date)
                let dateLabel = label as! UILabel
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = DateFormatter.Style.short
                dateFormatter.timeStyle = DateFormatter.Style.none
                let strDate = dateFormatter.string(from: date)
                dateLabel.text = strDate
                editCardTableView.reloadData()
            }
            
        }
    }
}
