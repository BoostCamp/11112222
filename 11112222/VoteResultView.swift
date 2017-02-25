//
//  VoteResultView.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 24..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit

class VoteResultView: UIView {
    var voteItem : VoteItem?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bodyLabel: UILabel!

    @IBOutlet weak var progressView: UIProgressView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitialization()
    }
    
    func commonInitialization() {
        let view = Bundle.main.loadNibNamed("VoteResultView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        
        
        self.addSubview(view)
    }
    
    
    override func layoutSubviews() {
        let transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressView.transform = transform
    }
    
    func configure(card: Card, id: String){
        if let votes = card.votes{
            let votesArray = votes.map{ $0.1 }
            print(votesArray)
            let myVotes : [String] = votesArray.filter{ $0 ==  id}
            let voteRate = myVotes.count/card.voteCount!
        }
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
