//
//  EditCommentViewController.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 7..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit
protocol EditCommentViewControllerDelegate {
    func endEdittingWithText(message: String)
}
class EditCommentViewController: UIViewController, PlaceHolderTextViewDelegate {
    // MARK: - State Enum
    enum EditState { case post, edit } // POST는 최초, Edit은 텍스트가 있을 때 수정

    // MARK: - IBOutlet
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var placeholderTextView: PlaceHolderTextView!
    @IBOutlet weak var sendButton: UIButton!
    var input : String?
    
    var state : EditState?
    var delegate : EditCommentViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        placeholderTextView.delegate = self
        placeholderTextView.isHidden = true

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {

        placeholderTextView.textView.becomeFirstResponder()
        if let inputData = input {
            placeholderTextView.textView.text = inputData
            placeholderTextView.textViewDidChange(placeholderTextView.textView)
        }

        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.placeholderTextView.textView.resignFirstResponder()
        unsubscribeFromKeyboardNotifications()
        super.viewWillDisappear(animated)
    }
    
    // MARK: - calculate over rapping keyboard and hide & show keyboard
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

    func keyboardWillShow(_ notification:Notification) {
//        let keyboardRect = getKeyboardRect(notification)
//        let textview = findFirstResponder() as! UITextView
//        if keyboardRect.contains(textView.frame.origin) { // bottom text view
        placeholderTextView.isHidden = false
        view.frame.origin.y = 0 - getKeyboardRect(notification).height
//        }
    }
    
    func keyboardDidShow(_ notification:Notification) {
    }
    
    // 키보드 사라지기 전 텍스트뷰 사라지게 하자.
    func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    func getKeyboardRect(_ notification:Notification) -> CGRect {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue
    }
    
    func findFirstResponder() -> UIResponder? {
        for v in self.view.subviews {
            if v.isFirstResponder {
                return (v as UIResponder)
            }
        }
        return nil
    }

    func backgroundTapped(_ sender : UITapGestureRecognizer) {
        
        if sender.state == .ended {
            if placeholderTextView.isEmpty { // post -> empty
                dismiss(animated: true, completion: nil)
            } else {
                showAlertView()
            }
        }
    }
    
    // MARK: - PlaceHolderTextView Delegate
    func hasText(_ flag: Bool) {
        print("hasText: \(flag)")
        configureUI(flag)
    }
    
    // MARK: - configure UI
    func configureUI(_ flag: Bool) {
        if flag { // 있어
            sendButton.isHidden = false
            
        } else { // 없어
            if state == EditState.post {
                sendButton.isHidden = true
            }
        }
    }
    
    func showAlertView() {
        let dimissAlertController: UIAlertController = UIAlertController(title: nil, message: "입력을 삭제하시겠습니까?", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "계속 작성", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
            self.placeholderTextView.textView.becomeFirstResponder()
        }
        dimissAlertController.addAction(cancelAction)
        
        let okAction : UIAlertAction = UIAlertAction(title: "삭제", style: .destructive) { action -> Void in
            
            self.dismiss(animated: true, completion: nil)
        }
        dimissAlertController.addAction(okAction)
        //Present the AlertController
        self.present(dimissAlertController, animated: true, completion: nil)
    }
    
    
    // MARK: - IBAction
    @IBAction func SendButtonClick(_ sender: Any) {
        delegate?.endEdittingWithText(message: placeholderTextView.textView.text)
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
