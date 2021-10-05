//
//  ImageSelectViewController.swift
//  Instagram2
//
//  Created by Kohei Yoshida on 2021/09/30.
//

import UIKit
import CLImageEditor

class ImageSelectViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLImageEditorDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func handleLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let pickerController = UIImagePickerController()
            
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true ,completion: nil)
        
    }
    }
    
    @IBAction func handleCameraButton(_ sender: Any) {
        
        UIImagePickerController.isSourceTypeAvailable(.camera)
        
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        pickerController.sourceType = .camera
        self.present(pickerController,animated: true,completion: nil)
        
    }
    
    
    @IBAction func handlecancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil {
            
            let image = info[.originalImage] as! UIImage
            
            print("DEBUG_PRINT:image = \(image)")
            
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            editor.modalPresentationStyle = .fullScreen
            
            picker.present(editor, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        
        postViewController.image = image!
        
        editor.present(postViewController,animated: true,completion: nil)
    }
    
    
    func imageEditorDidCancel(_ editor: CLImageEditor!) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
