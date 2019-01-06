//
//  TaskRepositoryProtocol.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/01.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import Foundation

protocol TaskRepositoryProtocol:class {
    // データを保存・読み込みしたらcompletionを実行します。
    func save(_ tasks: [Event], completion: (()->Void))
    func load(completion: (@escaping ([Event])->Void))
}
