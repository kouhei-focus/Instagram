//
//  PostTableViewCell.swift
//  Instagram2
//
//  Created by Kohei Yoshida on 2021/10/03.
//

import UIKit
import FirebaseStorageUI
//画像を一気に大量にダウンロードすると処理に時間がかかるのでそれを防いでくれる

class PostTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    @IBOutlet weak var commentButton: UIButton!
    
    
    @IBOutlet weak var commentNameLabel: UILabel!
    
    
    
    @IBOutlet weak var commentLabel: UILabel!
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setPostData(_ postData : PostData ) {
        
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        let imageRef = Storage.storage().reference().child(Const.imagePath).child(postData.id + "jpg")
        postImageView.sd_setImage(with: imageRef)
        
        self.captionLabel.text = "\(postData.name!): \(postData.caption!)"
        
        
       
       
        var countNumber = 0
        
        var allComment = ""
        
        print("コメントの数:\(postData.comment.count)")
        
        while countNumber < postData.comment.count {
            allComment += "\(postData.comment[countNumber])\n"
            
            countNumber += 1
            
        
            
        }
        
        
        
        self.commentLabel.text = "\(allComment)"
        
        
        
        
        self.dateLabel.text = ""
        
        if let date = postData.date {
            
            let formatter = DateFormatter()
            
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            
            self.dateLabel.text = dateString
            
            
            
            
        }
        
        
        let likedNumber = postData.likes.count
        
        likeLabel.text = "\(likedNumber)"
        
        if postData.isLiked {
            
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
            
            
        } else {
            
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        
        
        
    }
    
    
    
    
    
    
}
