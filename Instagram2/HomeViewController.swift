//
//  HomeViewController.swift
//  Instagram2
//
//  Created by Kohei Yoshida on 2021/09/30.
//

import UIKit
import Firebase

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray : [PostData] = []
    
    var selectdata:PostData!
    
    var listener : ListenerRegistration?
    //データが更新される度にリアルタイム取得をする
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        

        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
        print("DEBUG_PRINT: viewWillAppear")
        // ログイン済みか確認
        if Auth.auth().currentUser != nil {
            // listenerを登録して投稿データの更新を監視する
            let postsRef = Firestore.firestore().collection(Const.PostPath).order(by: "date", descending: true)
            listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
                if let error = error {
                    print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                    return
                }
                // 取得したdocumentをもとにPostDataを作成し、postArrayの配列にする。
                self.postArray = querySnapshot!.documents.map { document in
                    print("DEBUG_PRINT: document取得 \(document.documentID)")
                    let postData = PostData(document: document)
                    return postData
                }
                // TableViewの表示を更新する
                self.tableView.reloadData()
            }
        }
        
        
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("DEBUG_PRINT:viewDidDisappear")
        
        listener?.remove()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)  as! PostTableViewCell
        
        cell.setPostData(postArray[indexPath.row])
        
        cell.likeButton.addTarget(self, action:#selector(handleButton(_:forEvent:)), for: .touchUpInside)
        
        cell.commentButton.addTarget(self, action: #selector(handleCommentButton(_:forEvent:)), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func handleButton(_ sender: UIButton, forEvent event: UIEvent) {
        
        print("DEBUG_PRINT:likeボタンがタップされました。")
        
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        let postData = postArray[indexPath!.row]
        
        
        if let myid = Auth.auth().currentUser?.uid {
            var updateValue :FieldValue
            if postData.isLiked {
                
                updateValue = FieldValue.arrayRemove([myid])
            } else {
                updateValue = FieldValue.arrayUnion([myid])
            }
            
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            
            postRef.updateData(["likes":updateValue])
            
            
        }
        
    }
    
    
    @objc func  handleCommentButton(_ sender: UIButton, forEvent event: UIEvent) {
        
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        selectdata = postArray[indexPath!.row]
      
       
        
        
        let commentVC = self.storyboard?.instantiateViewController(withIdentifier: "Comment") as! CommentViewController
        
        commentVC.selectedData = selectdata.name!
        commentVC.captionText = selectdata.caption!
        
        let postData = postArray[indexPath!.row]
        
        commentVC.postData = postData
        
        self.present(commentVC,animated: true,completion: nil)
        
    }
    

    
}
