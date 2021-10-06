//
//  CommentViewController.swift
//  Instagram2
//
//  Created by Kohei Yoshida on 2021/10/04.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    
    @IBOutlet weak var displayNameLabel: UILabel!
    
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var commentTextField: UITextField!
    
    var selectedData:String!
    
    var captionText:String!
    
    var postData:PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedData!)
        
        displayNameLabel.text = selectedData
        captionLabel.text = captionText
        
        textField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func comment(_ sender: Any) {
        
        
        let user = Auth.auth().currentUser
        var updateValue: FieldValue
        updateValue = FieldValue.arrayUnion([commentTextField.text!])
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        
        postRef.updateData(["comment": updateValue])
        
        postRef.updateData(["commentName":user!.displayName])
       
      
        
        
        
        self.dismiss(animated: true, completion: nil)
        
        
        print(postRef)
    }
    
    
}
