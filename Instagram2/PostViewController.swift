//
//  PostViewController.swift
//  Instagram2
//
//  Created by Kohei Yoshida on 2021/09/30.
//

import UIKit
import Firebase
import SVProgressHUD

class PostViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    var image:UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func handlePostButton(_ sender: Any) {
        
        let imageData = image.jpegData(compressionQuality: 0.75)
        
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        
        let imageRef = Storage.storage().reference().child(Const.imagePath).child(postRef.documentID + "jpg")
        
        SVProgressHUD.show()
        
        let metadata = StorageMetadata()
        
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData!, metadata: metadata) { (metadata , error) in
            
            if error != nil {
                
                print(error!)
                SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                
                UIApplication.shared.windows.first{ $0.isKeyWindow}?.rootViewController?.dismiss(animated: true, completion: nil)
                
                return
                
                
            }
            
            let name = Auth.auth().currentUser?.displayName
            
            let postDic = [
                "name": name!,
                "caption": self.textField.text!,
                "date": FieldValue.serverTimestamp(),
                ] as [String : Any]
            
            postRef.setData(postDic)
            
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            
            UIApplication.shared.windows.first{$0.isKeyWindow}?.rootViewController?.dismiss(animated: true, completion: nil)
            //モーダルで遷移された画面を３つ伝ってきているので、一気に戻るための処理が描かれている。
            
            
            
            
        }
        
        
        
        
    }
    
    
    @IBAction func handleCancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
