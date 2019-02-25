//
//  CommentViewController.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/10.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    
    let postCollection = PostCollection.shared
    let userDefaults = UserDefaults.standard
    var pngImageData: Data?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    @IBOutlet weak var pictureImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pngImageData = userDefaults.data(forKey: "image")
        if let setData = pngImageData{
            let image = UIImage(data: setData)
            pictureImage.image = image
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func didTouchSaveButton(_ sender: Any) {
        guard let title = titleTextField.text else{return}
        guard let note = noteTextField.text else{return}
        guard let imageData = pngImageData else{return}
        let imageDataBase64String = imageData.base64EncodedString()
        guard let aiLabel: String = userDefaults.object(forKey: "aiLabel") as? String else{
            return
        }
        print(aiLabel)
        
        
        if (title.isEmpty) {
            alert("エラー","タイトルを入力して下さい。",nil)
            return
        }
        
        let post = Post()
        post.title = title
        post.note = note
        post.image = imageDataBase64String
        post.label = aiLabel
        postCollection.addPost(post)
        
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ListNavigationController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
