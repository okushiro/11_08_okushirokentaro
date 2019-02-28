//
//  Post.swift
//  MyLunch
//
//  Created by 奥城健太郎 on 2019/02/10.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import Foundation

class Post:Codable {
    var id: String?
    var title: String = ""
    var note: String = ""
    var image: String = ""
    var label: String = ""
    
    func setData(data: [String: Any]) {
        if let title = data["title"] as? String {
            self.title = title
        }
        if let note = data["note"] as? String {
            self.note = note
        }
        if let image = data["image"] as? String {
            self.image = image
        }
        if let label = data["label"] as? String {
            self.label = label
        }
    }
    
    func toDictionary() -> [String:Any]{
        return [
            "title": self.title,
            "note": self.note,
            "image": self.image,
            "label": self.label
        ]
    }
}
