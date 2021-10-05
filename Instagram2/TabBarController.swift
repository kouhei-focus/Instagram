//
//  TabBarController.swift
//  Instagram2
//
//  Created by Kohei Yoshida on 2021/09/30.
//

import UIKit
import Firebase

class TabBarController: UITabBarController,UITabBarControllerDelegate{
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor(red:1.0, green: 0.44, blue: 0.11, alpha: 1)
        
        self.tabBar.barTintColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        
        self.delegate = self
    
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ImageSelectViewController {
            
            let imageSelectViewContoller = storyboard!.instantiateViewController(withIdentifier: "ImageSelect")
            present(imageSelectViewContoller , animated: true)
                     return false
        } else {
            return true
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            
            self.present(loginViewController! , animated: true , completion: nil)
        }
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
