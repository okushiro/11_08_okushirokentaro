//
//  FirestorePostRepository.swift
//  MyLunch2
//
//  Created by 奥城健太郎 on 2019/02/25.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import Foundation
import Firebase

class FirestorePostRepository: PostRepositoryProtocol{
    
    let db = Firestore.firestore()
    
    private func getCollectionRef () -> CollectionReference {
        guard let uid = User.shared.getUid() else {
            fatalError ("Uidを取得出来ませんでした。")
        }
        print(uid)
        return db.collection("Users").document(uid).collection("Posts")
    }
    
    func save(posts: [Post], completion: () -> Void) {
        let ref = self.getCollectionRef()
        print(ref.path)
        posts.forEach { (post) in
            if let id = post.id {
                let documentRef = ref.document(id)
                documentRef.setData(post.toDictionary())
            } else {
            let documentRef = ref.addDocument(data:post.toDictionary())
                post.id = documentRef.documentID
            }
        }
        print("saveしてます")
        completion()
    }
    
    func load(completion: @escaping ([Post]) -> Void) {
        let ref = self.getCollectionRef()
        var posts: [Post] = []
        ref.getDocuments{ (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let documents = querySnapshot?.documents{
                    documents.forEach({ (document) in
                        let data = document.data()
                        let post = Post()
                        post.id = document.documentID
                        post.setData(data: data)
                        posts.append(post)
                    })
                }
            }
            print("loadしてます")
            completion(posts)
        }
        
    }
    
}
