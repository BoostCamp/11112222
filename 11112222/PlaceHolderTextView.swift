//
//  PlaceHolderTextView.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 14..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

protocol PlaceHolderTextViewDelegate {
    func hasText(_ flag : Bool)
}

@IBDesignable class PlaceHolderTextView: UIView, UITextViewDelegate {

    var view : UIView?
    var isEmpty : Bool = true
    
    // MARK: -IBAction
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var labelPlaceholder : UILabel!
    @IBInspectable var placeholderText: String = "내용을 입력하세요..." {
        didSet {
            labelPlaceholder.text = placeholderText
        }
    }
    
    var delegate : PlaceHolderTextViewDelegate?
    func commonXibSetup() {
    guard let view = loadViewFromNib() else
    {
        return
    }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        textView.delegate = self
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PlaceHolderTextView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonXibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonXibSetup()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let trimmed = textView.text.trimmingCharacters(in: .whitespaces)
        
        // labelPlaceHolder는 trim이 아니여도 없어져야 함 띄어쓰기만해도
        if textView.hasText && isEmpty { // isEmpty는 한번만 호출되기 위한 flag
            labelPlaceholder?.isHidden = true
            if !trimmed.isEmpty {
                delegate?.hasText(true)
                isEmpty = false
            }
        }
        else if !textView.hasText { // 텍스트가 없다.
            labelPlaceholder?.isHidden = false // placeholder 보여주자
            delegate?.hasText(false)
            isEmpty = true
        }
    }
}
