//
//  VoteResultBodyTableViewCell.swift
//  11112222
//
//  Created by Dongyoon Kang on 2017. 2. 24..
//  Copyright © 2017년 Dongyoon Kang. All rights reserved.
//

import UIKit
import Nuke

class VoteResultBodyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var optionTextLabel: UILabel!
    @IBOutlet weak var optionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        let transform = CGAffineTransform(scaleX: 1.0, y: 10.0)
        progressView.transform = transform
        progressView.progressTintColor = UIColor.FlatColor.Green.ChateauGreen
    }
    
    func configureCell(card: Card, vote: VoteItem){
        optionImageView.image = nil
        if let imageUrl = vote.imageUrl {
            if let url = URL.init(string: imageUrl){
                Nuke.loadImage(with: url, into: optionImageView)
            }
        }
        if let optionText = vote.text {
            optionTextLabel.text = optionText
        } else {
            optionTextLabel.text = ""
        }
        
        if let votes = card.votes{
            let votesArray = votes.map{ $0.1 }
            let myVotes : [String] = votesArray.filter{ $0 ==  vote.id!}
            if let voteCount = card.voteCount {
                let voteRate = getVoteRate(myVotes.count, voteCount)
                voteCountLabel.text = "\(myVotes.count) Votes"
                if voteRate > 0.1 {
                    progressView.setProgress(0.1, animated: false)
                } else {
                }
                progressView.setProgress(Float(voteRate), animated: true)
            }
            
        }else { // 여긴 올 수 없는 영역 바꾸자.
            voteCountLabel.text = "0 Votes"
            progressView.setProgress(0.0, animated: true)
        }
        
    }
    
    private func getVoteRate(_ n1: Int, _ n2: Int) -> Float{
        return Float(n1) / Float(n2)
    }
    
}
