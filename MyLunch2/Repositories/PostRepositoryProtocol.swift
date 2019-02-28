//
//  PostRepositoryProtocol.swift
//  MyLunch2
//
//  Created by 奥城健太郎 on 2019/02/25.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import Foundation

protocol PostRepositoryProtocol:class {
    func save(posts:[Post], completion: () -> Void)
    func load(completion: @escaping (_ posts:[Post]) -> Void)
}

