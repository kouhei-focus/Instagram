



import UIKit
import Firebase

class PostData:NSObject {
    
    var id: String
    
    var name :String?
    
    var caption:String?
    
    var date :Date?
    
    var likes:[String] = []
    
    var isLiked:Bool = false
    
    var comment:String?
    
    var commentName:String?
    
    
    init(document:QueryDocumentSnapshot) {
        
        self.id = document.documentID
        
        let postDic = document.data()
        
        self.name = postDic["name"] as? String
        
        self.caption = postDic["caption"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
            
        }
        
        self.comment = postDic["comment"] as? String
        
        self.commentName = postDic["commentName"] as? String
        
        if let myid = Auth.auth().currentUser?.uid {
            
            if self.likes.firstIndex(of: myid) != nil {
                self.isLiked = true
            }
            
        }
        
        
        
        
        
    }
    
    
    
}
